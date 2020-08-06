module SygiopsSupport
  class GreetJob < ApplicationJob
    queue_as :default

    def perform(*args)
      # Do something later
      Rails.logger.info "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"
    end
  end
end
