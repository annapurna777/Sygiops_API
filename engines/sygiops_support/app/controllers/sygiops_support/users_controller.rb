require_dependency "sygiops_support/application_controller"

module SygiopsSupport
  class UsersController < ApplicationController

    def index
      render json: User.all
    end

    def email_address
      render json: EmailAddress.all
    end

  end
end
