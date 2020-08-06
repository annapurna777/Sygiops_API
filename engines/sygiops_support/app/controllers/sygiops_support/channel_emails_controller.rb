require_dependency "sygiops_support/application_controller"

module SygiopsSupport
  class ChannelEmailsController < ApplicationController
      skip_before_action :verify_authenticity_token
    def index
      # binding.pry
      active_channels = SygiopsSupport::Channel.where(area: "Email::Account",active: true)
      inactive_channels = SygiopsSupport::Channel.where(area: "Email::Account",active: false)
      render json: {
        active_channels: active_channels,
        inactive_channels: inactive_channels
      }
    end

    def probe

      # probe settings based on email and password
      result = EmailHelper::Probe.full(
        email:    params[:email],
        password: params[:password],
        folder:   params[:folder],
      )

      # verify if user+host already exists
      if result[:result] == 'ok'
        return if account_duplicate?(result)
      end

      render json: result
    end

    # {"adapter"=>"smtp", "options"=>{"host"=>"smtp.gmail.com", "user"=>"annapurna.tiwari1998@gmail.com", "password"=>"[FILTERED]", "port"=>"25"}, "email"=>"annapurna.tiwari1998@gmail.com", "channel_id"=>14}

    def outbound
      # binding.pry

      # verify access
      # return if params[:channel_id] && !check_access(params[:channel_id])
      params[:options][:user_name] = params[:options][:user]
      params[:email] = params[:options][:user]

      # connection test
      render json: EmailHelper::Probe.outbound(params, params[:options][:user])
    end

    def inbound
    # binding.pry
      # verify access
      return if params[:channel_id] && !check_access(params[:channel_id])

      # connection test
      result = EmailHelper::Probe.inbound(params)

      # check account duplicate
      return if account_duplicate?({ setting: { inbound: params } }, params[:channel_id])

      render json: result
    end

    # {"inbound"=>{"adapter"=>"imap", "options"=>{"host"=>"imap.gmail.com", "port"=>993, "ssl"=>true, "user"=>"annapurna.tiwari1998@gmail.com", "password"=>"[FILTERED]"}}, "outbound"=>{"adapter"=>"smtp", "options"=>{"host"=>"smtp.gmail.com", "user"=>"annapurna.tiwari1998@gmail.com", "password"=>"[FILTERED]", "port"=>"25"}, "email"=>"annapurna.tiwari1998@gmail.com", "channel_id"=>14}, "meta"=>{}, "channel_id"=>14, "group_id"=>1, "email"=>"annapurna.tiwari1998@gmail.com"}

    def verify
      # binding.pry
      params.permit!
      email = params[:outbound][:options][:user]
      email = email.downcase
      channel_id = params[:channel_id]
      params[:outbound][:options][:user_name] = params[:outbound][:options][:user]
      params[:inbound].delete("authenticity_token")
      params[:outbound].delete("authenticity_token")

      # verify access
      # return if channel_id && !check_access(channel_id)

      # check account duplicate
      return if account_duplicate?({ setting: { inbound: params[:inbound] } }, channel_id)

      # check delivery for 30 sec.
      result = EmailHelper::Verify.email(
        outbound: params[:outbound].to_h,
        inbound:  params[:inbound].to_h,
        sender:   email,
        subject:  params[:subject],
      )

      if result[:result] != 'ok'
        render json: result
        return
      end

      # fallback
      if !params[:group_id]
        params[:group_id] = Group.first.id
      end

      # update account
      if channel_id
        channel = Channel.find(channel_id)
        channel.update!(
          options:      {
            inbound:  params[:inbound].to_h,
            outbound: params[:outbound].to_h,
          },
          group_id:     params[:group_id],
          last_log_in:  nil,
          last_log_out: nil,
          status_in:    'ok',
          status_out:   'ok',
        )
        render json: result
        return
      end

      # create new account
      # options: {"outbound"=>{"adapter"=>"smtp", "options"=>{"openssl_verify_mode"=>"none", "port"=>25, "domain"=>"gmail.com", "enable_starttls_auto"=>true, "user_name"=>channel["options"]["outbound"]["user_name"], "password"=>channel["options"]["outbound"]["password"], "authentication"=>nil, "ssl"=>nil, "tls"=>nil, "open_timeout"=>nil, "read_timeout"=>nil, "enable_starttls"=>nil, "host"=>"smtp.gmail.com"}}}
      params["outbound"]["options"]["openssl_verify_mode"] = "none"
      params["outbound"]["options"]["domain"] = "gmail.com"
      params["outbound"]["options"]["enable_starttls_auto"] = true
      params["outbound"]["options"]["authentication"] = nil
      params["outbound"]["options"]["ssl"] = nil
      params["outbound"]["options"]["tls"] = nil
      params["outbound"]["options"]["open_timeout"] = nil
      params["outbound"]["options"]["read_timeout"] = nil
      params["outbound"]["options"]["enable_starttls"] = nil

      channel = Channel.create(
        area:         'Email::Account',
        options:      {
          inbound:  params[:inbound].to_h,
          outbound: params[:outbound].to_h,
        },
        # group_id:     params[:group_id],
        last_log_in:  nil,
        last_log_out: nil,
        status_in:    'ok',
        status_out:   'ok',
        active:       true,
      )

      # binding.pry
      # if !Channel.find_by(area: 'Email::Notification', active: true)
      notification_channel = Channel.create(active: true, preferences: {"online_service_disable"=>true}, last_log_in: nil, last_log_out: nil, status_in: "ok", status_out: "ok", area: "Email::Notification", options: {"outbound"=>{"adapter"=>"smtp", "options"=>{"openssl_verify_mode"=>"none", "port"=>25, "domain"=>"gmail.com", "enable_starttls_auto"=>true, "user_name"=>channel["options"]["outbound"]["options"]["user_name"], "password"=>channel["options"]["outbound"]["options"]["password"], "authentication"=>nil, "ssl"=>nil, "tls"=>nil, "open_timeout"=>nil, "read_timeout"=>nil, "enable_starttls"=>nil, "host"=>"smtp.gmail.com"}}})
    # end

      # remember address && set channel for email address
      address = EmailAddress.find_by(email: email)

      # on initial setup, use placeholder email address
      if Channel.count == 1
        address = EmailAddress.first
      end

      if address
        address.update!(
          realname:   params[:meta][:realname],
          email:      email,
          active:     true,
          channel_id: channel.id,
        )
      else
        EmailAddress.create(
          realname:   params[:inbound][:realname],
          email:      email,
          active:     true,
          channel_id: channel.id,
        )
      end

      render json: result
    end

    def enable
      channel = Channel.find_by(id: params[:id], area: 'Email::Account')
      channel.active = true
      channel.save!
      render json: {}
    end

    def disable
      channel = Channel.find_by(id: params[:id], area: 'Email::Account')
      channel.active = false
      channel.save!
      render json: {}
    end

    def destroy
      channel = Channel.find_by(id: params[:id], area: 'Email::Account')
      channel.destroy
      render json: {}
    end

    def group
      check_access
      channel = Channel.find_by(id: params[:id], area: 'Email::Account')
      channel.group_id = params[:group_id]
      channel.save!
      render json: {}
    end

    def notification
      params.permit!

      check_online_service

      adapter = params[:adapter].downcase

      email = Setting.get('notification_sender')

      # connection test
      result = EmailHelper::Probe.outbound(params, email)

      # save settings
      if result[:result] == 'ok'

        Channel.where(area: 'Email::Notification').each do |channel|
          active = false
          if adapter.match?(/^#{channel.options[:outbound][:adapter]}$/i)
            active = true
            channel.options = {
              outbound: {
                adapter: adapter,
                options: params[:options].to_h,
              },
            }
            channel.status_out   = 'ok'
            channel.last_log_out = nil
          end
          channel.active = active
          channel.save
        end
      end
      render json: result
    end

    private

    def account_duplicate?(result, channel_id = nil)
      Channel.where(area: 'Email::Account').each do |channel|
        next if !channel.options
        next if !channel.options[:inbound]
        next if !channel.options[:inbound][:adapter]
        next if channel.options[:inbound][:adapter] != result[:setting][:inbound][:adapter]
        next if channel.options[:inbound][:options][:host] != result[:setting][:inbound][:options][:host]
        next if channel.options[:inbound][:options][:user] != result[:setting][:inbound][:options][:user]
        next if channel.options[:inbound][:options][:folder].to_s != result[:setting][:inbound][:options][:folder].to_s
        next if channel.id.to_s == channel_id.to_s

        render json: {
          result:  'duplicate',
          message: 'Account already exists!',
        }
        return true
      end
      false
    end

    def check_online_service
      return true if !Setting.get('system_online_service')

      raise Exceptions::NotAuthorized
    end

    def check_access(id = nil)
      if !id
        id = params[:id]
      end
      return true if !Setting.get('system_online_service')

      channel = Channel.find(id)
      return true if channel.preferences && !channel.preferences[:online_service_disable]

      raise Exceptions::NotAuthorized
    end

  end
end
