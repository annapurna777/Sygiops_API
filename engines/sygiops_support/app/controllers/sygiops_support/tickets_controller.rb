require_dependency "sygiops_support/application_controller"

module SygiopsSupport
  class TicketsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
      @response = {}
      if params["category"] && (params["category"] != "none") && params["option"]
          @response = Ticket.filter_tickets(params["category"],params["option"])
      else
        @response["about"] = "none"
        @response["none"] = Ticket.all.map{ |t| t.as_json.merge(priority: t.priority.name, customer: t.customer.firstname+" "+t.customer.lastname,state: t.state.name)}.as_json
      end
      render json: @response
    end

    def get_options
      if params[:parameter] == "state"
        render json: Ticket::State.all
      end
    end

    def show
      ticket  = Ticket.find_by(id: params[:id])
      articles = Ticket::Article.where(ticket_id: ticket.id)
      user    = User.find_by(id: ticket.customer_id)
      role    = Role.find_by(id: user.role_id)
      users   = User.all.pluck(:email,:firstname,:lastname,:id)
      @attachments = {}
      articles.each do |article|
        @attachments[article.id] = article.attachments
      end
      response = {
        ticket: ticket,
        article: articles,
        user: user,
        users: users,
        role: role,
        attachments: @attachments
      }
      render json: response
    end

    def get_attachment(ticket_id , article_id)

      ticket = Ticket.find_by(id: ticket_id)

      article = Ticket::Article.find_by(id: article_id)
      if ticket.id != article.ticket_id

        if ticket.state.state_type.name != 'merged'
          raise Exceptions::NotAuthorized, 'No access, article_id/ticket_id is not matching.'
        end

        ticket = article.ticket
      end
      attachments = []

      list = article.attachments || []

      list.each { |file|

        disposition = "attachment"

        content = file.content
        attachment = {
          content:     content,
          filename:    file.filename,
          type:        file.preferences['Content-Type'] || file.preferences['Mime-Type'] || 'application/octet-stream',
          disposition: disposition
        }

        attachments.push(attachment)
      }
      attachments
    end

    #     =begin
    #
    #   success = NotificationFactory::Mailer.send(
    #     recipient:    User.find(123),
    #     subject:      'some subject',
    #     body:         'some body',
    #     content_type: '', # optional, e. g. 'text/html'
    #     message_id:   '<some_message_id@fqdn>', # optional
    #     references:   ['message-id123', 'message-id456'], # optional
    #     attachments:  [attachments...], # optional
    #   )
    #
    # =end

    def send_reply
      ticket = Ticket.find_by(id: params[:ticket_id])
      from = Channel.find_by(id: ticket["preferences"]["channel_id"]).options["outbound"]["options"]["user_name"]
      ticket_article = Ticket::Article.find_by(ticket_id: ticket.id)
      article = ""
      response = {result: "ok"}
      to = ""
      params[:to]&.each do |x|
        to = to + User.find_by(id: x).email+","
      end
      to = to[0..-2]
      cc = ""
      if params[:cc] != ""
        params[:cc]&.each do |y|
          cc = cc + User.find_by(id: y).email+","
        end
      end
      cc= cc[0..-2]
      ticket.with_lock do
        article = SygiopsSupport::Ticket::Article.new(
          ticket_id:    ticket.id,
          type_id:      1,
          sender_id:    2,
          in_reply_to:  ticket_article.message_id,
          content_type: "text/html",
          message_id:   "<ticket_reply.#{DateTime.current.to_s(:number)}.#{ticket.id}.#{from}.#{rand(999_999)}@localhost>",
          body:         params[:body],
          from:         from,
          reply_to:     nil,
          to:           to,
          cc:           cc,
          subject:      ticket.title,
          internal:     false,
        )

        article.save!
        if !params[:file].blank?
          params[:file]&.each do |attachment|
            filename = attachment.original_filename.force_encoding('utf-8')
            if !filename.force_encoding('UTF-8').valid_encoding?
              filename = filename.utf8_encode(fallback: :read_as_sanitized_binary)
            end
            Store.add(
              object:      'SygiopsSupport::Ticket::Article',
              o_id:        article.id,
              data:        attachment.read,
              filename:    filename,
              preferences: {"Content-Type" => attachment.content_type}
            )
          end
        end
        channel = SygiopsSupport::Channel.find_by(area: 'Email::Notification', active: true)
        result = nil
        begin
        result = channel.deliver(
          {
            message_id:   article.message_id,
            in_reply_to:  article.in_reply_to,
            references:   ticket.get_references([article.message_id]),
            from:         article.from,
            to:           article.to,
            cc:           article.cc,
            subject:      article.subject,
            content_type: article.content_type,
            body:         article.body,
            attachments:  article.attachments,
            security:     article.preferences[:security],
          },
          false
        )
        rescue => e
          response["result"] = "failed"
        end

      end
      render json: response
    end

  end
end
