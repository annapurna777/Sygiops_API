require_dependency "sygiops_support/application_controller"

module SygiopsSupport
  class CalendarsController < ApplicationController
    skip_before_action :verify_authenticity_token

    # Parameters: {"name"=>"new calendar", "timezone"=>"Asia/Kolkata", "business_hours"=>{"mon"=>{"active"=>true, "timeframes"=>[["09:00", "17:00"], ["13:00", "17:00"]]}, "tue"=>{"active"=>true, "timeframes"=>[["09:00", "17:00"]]}, "wed"=>{"active"=>true, "timeframes"=>[["09:00", "17:00"]]}, "thu"=>{"active"=>true, "timeframes"=>[["09:00", "17:00"], ["13:00", "17:00"]]}, "fri"=>{"active"=>true, "timeframes"=>[["09:00", "17:00"]]}, "sat"=>{"active"=>false, "timeframes"=>[["10:00", "14:00"]]}, "sun"=>{"active"=>false, "timeframes"=>[["10:00", "14:00"]]}}, "ical_url"=>"", "note"=>"", "id"=>"c-1"}

    def index
      render json: Calendar.all
    end

    def create
      # binding.pry
      response = {}
      business_hours = {}
      count = 0
      @days = ["mon","tue","wed","thu","fri","sat","sun"]
      @days.each do |day|
        business_hours[day] = {"timeframes"=> []}
        business_hours[day]["active"] =params["business_hours"][day]["active"]
        params["business_hours"][day]["timeframes"].each_with_index do |item , index|
          next if index.odd?
          duration = [item[0] , params["business_hours"][day]["timeframes"][index+1][0] ]
          business_hours[day]["timeframes"].push(duration)
          business_hours[day]["timeframes"].flatten
        end
      end

      calendar = Calendar.new
      calendar.name = params["name"]
      calendar.business_hours = business_hours
      calendar.public_holidays = params["public_holidays"]
      if calendar.save!
        response["result"] = "ok"
      else
        response["result"] = "failed"
      end
      render json: response
    end

  end
end
