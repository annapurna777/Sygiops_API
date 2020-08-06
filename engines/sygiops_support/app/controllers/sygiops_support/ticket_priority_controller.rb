require_dependency "sygiops_support/application_controller"

module SygiopsSupport
  class TicketPriorityController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
      render json: Ticket::Priority.all.sort
    end

    def create
      # binding.pry
      response = {}
      type = Ticket::Priority.new(name: params[:name],note: params[:note])
      if type.save
        response[:result] = "ok"
      else
        response[:result] = "failed"
      end
      render json: response
    end

    def update
      # binding.pry
      response = {}
      type = Ticket::Priority.find_by(id: params[:id])
      if type
        type.update(name: params[:name],note: params[:note])
        response[:result] = "ok"
      else
        response[:result] = "failed"
      end

      render json: response
    end

    def destroy
      # binding.pry
      response = {}
      type = Ticket::Priority.find_by(id: params[:id])
      if type
        type.destroy
        response[:result] = "ok"
      else
        response[:result] = "failed"
      end

      render json: response
    end
  end
end
