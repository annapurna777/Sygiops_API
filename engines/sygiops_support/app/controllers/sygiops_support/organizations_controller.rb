require_dependency "sygiops_support/application_controller"

module SygiopsSupport
  class OrganizationsController < ApplicationController
    skip_before_action :verify_authenticity_token
    # {"name"=>"Sygitech", "shared"=>true, "note"=>"sygitech note", "active"=>true, "domain_assignment"=>false, "domain"=>"sygitech.com", "id"=>"c-2"}

    def index
      render json: Organization.all
    end

    def fetch_timezones
      render json: Calendar.timezones
    end

    def create
      # binding.pry
      organization = Organization.new(name: params["name"],shared: params["shared"],domain_assignment: params["domain_assignment"],note: params["note"],active: params["active"],domain: params["domain"],timezone_name: params["timezone_name"])
      response = {}
      if organization.save!
        response["result"] = "ok"
      else
        response["result"] = "failed"
        response["reason"] = organization.errors.full_messages
      end
      render json: response
    end

  end
end
