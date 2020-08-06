require_dependency "sygiops_support/application_controller"

module SygiopsSupport
  class TicketTypesController < ApplicationController

    skip_before_action :verify_authenticity_token

    def index
      render json: Ticket::Type.all.sort
    end

    def create
      # binding.pry
      response = {}
      type = Ticket::Type.new(name: params[:name],note: params[:note])
      if type.save
        response[:result] = "ok"
      else
        response[:result] = "failed"
      end
      render json: response
    end

    def update
      response = {}
      type = Ticket::Type.find_by(id: params[:id])
      if type
        type.update(name: params[:name],note: params[:note])
        response[:result] = "ok"
      else
        response[:result] = "failed"
      end

      render json: response
    end

    def destroy
      response = {}
      type = Ticket::Type.find_by(id: params[:id])
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
