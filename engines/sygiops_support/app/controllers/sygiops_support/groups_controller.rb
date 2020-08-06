require_dependency "sygiops_support/application_controller"

module SygiopsSupport
  class GroupsController < ApplicationController
    skip_before_action :verify_authenticity_token

    # Parameters: {"name"=>"user2", "assignment_timeout"=>4, "follow_up_possible"=>"new_ticket", "follow_up_assignment"=>"true", "email_address_id"=>"", "signature_id"=>"", "note"=>"wgdgwfda", "active"=>true, "id"=>"c-4"}

    def fetch_datas
      response = render json: {"emails" => EmailAddress.all,"signatures" => Signature.all}
    end

    def index
      render json: Group.all
    end

    def create
      response = {}
      group = Group.new(signature_id: "1",email_address_id: params["email_address_id"],name:params["name"],assignment_timeout: params["assignment_timeout"],follow_up_possible: params["follow_up_possible"],follow_up_assignment: params["follow_up_assignment"],active: params["active"],note: params["note"])
      if group.save!
        response["result"] = "ok"
      else
        response["result"] = "failed"
      end
      render json: response
    end

    def update
      response = {}
      group = Group.find_by(id: params["id"])
      if group.active == true
        group.update(active: false)
        response["result"] = "ok"
      else
        group.update(active: true)
        response["result"] = "failed"
      end
      render json: response
    end

    def send_notification
      # binding.pry
    end

  end
end
