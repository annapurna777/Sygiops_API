module SygiopsSupport
  class Sla < ApplicationRecord
    store      :condition
    validates  :name, presence: true
    belongs_to :calendar, optional: true

    # after_create :assign_sla_times
    #
    # def assign_sla_times
    #   organization = Organization.find_by(id: params["organization_id"])
    #   calendar = Calendar.find_by(id: params["calendar_id"])
    #   timezone_name = organization.timezone_name
    #   biz = calendar.biz(timezone_name)
    #   if organization
    #     organization.update(sla_id: sla.id)
    #     organization.tickets.find_each(batch_size: 500) do |ticket|
    #
    #     end
    #   end
    # end

  end
end
