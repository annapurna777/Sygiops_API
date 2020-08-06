require_dependency "sygiops_support/application_controller"
# ["escalation_at", "2020-07-24 05:16:27"], ["first_response_escalation_at", "2020-07-23 11:16:26.898000"], ["close_escalation_at", "2020-07-24 05:16:27"]
module SygiopsSupport
  class SlasController < ApplicationController
    skip_before_action :verify_authenticity_token

    def fetch_datas
      response = {}
      response["organizations"] = Organization.all
      response["calendars"] = Calendar.all
      render json: response
    end

    def create
      response = {}
      response_time = hours2minutes(params["response_time"])
      resolution_time = hours2minutes(params["resolution_time"])
      sla = Sla.new(name: params["name"],calendar_id: params["calendar_id"],first_response_time: response_time,solution_time: resolution_time)
      calendar = Calendar.find_by(id: params["calendar_id"])
      biz = calendar.biz(organization.timezone_name)
      if sla.save!
        response["result"] = "ok"
        organization = Organization.find_by(id: params["organization_id"])
        if organization
          organization.update(sla_id: sla.id)
          organization.tickets.find_each(batch_size: 500) do |ticket|
            preferences = {}
            preferences[:escalation_calculation] = {
              first_response_at:   biz.time(response_time, :minutes).after(ticket.created_at),
              last_update_at:      Time.now,
              close_at:            nil,
              sla_id:              sla.id,
              sla_updated_at:      sla.updated_at,
              calendar_id:         calendar.id,
              calendar_updated_at: calendar.updated_at,
              escalation_disabled: false,
            }
            preferences[:channel_id] = ticket.preferences["channel_id"]
            ticket.update(first_response_escalation_at: biz.time(response_time, :minutes).after(ticket.created_at),close_escalation_at: biz.time(resolution_time, :minutes).after(ticket.created_at),escalation_at: biz.time(resolution_time, :minutes).after(ticket.created_at),preferences: preferences)
          end
        end
      else
        response["result"] = "failed"
        response["error"] = sla.errors.full_messages
      end

      render json: response
    end

    def index
    end

    def mark_as_default
      sla = Sla.find_by(id: params["id"])
      sla.update(default_create: true)
      default sla = Sla.find_by(default_create: true)
      default_create.update(default_create: false) if default_create
      calendar = Calendar.find_by(id: params["calendar_id"])
      organizations = Organization.where(sla_id: nil)
      response_time = hours2minutes(sla.first_response_time)
      resolution_time = hours2minutes(sla.solution_time)
      organizations.each do |organization|
        organization.update(sla_id: sla.id)
        biz = calendar.biz(organization.timezone_name)
        organization.tickets.find_each(batch_size: 500) do |ticket|
          preferences = {}
          preferences[:escalation_calculation] = {
            first_response_at:   biz.time(response_time, :minutes).after(ticket.created_at),
            last_update_at:      Time.now,
            close_at:            nil,
            sla_id:              sla.id,
            sla_updated_at:      sla.updated_at,
            calendar_id:         calendar.id,
            calendar_updated_at: calendar.updated_at,
            escalation_disabled: false,
          }
          preferences[:channel_id] = ticket.preferences["channel_id"]
          ticket.update(first_response_escalation_at: biz.time(response_time, :minutes).after(ticket.created_at),close_escalation_at: biz.time(resolution_time, :minutes).after(ticket.created_at),escalation_at: biz.time(resolution_time, :minutes).after(ticket.created_at))
        end
      end
    end

    private

    def hours2minutes(time)
      slice = time.split(":")
      minutes = (slice[0].to_i * 60) + (slice[1].to_i)
      minutes
    end

  end
end
