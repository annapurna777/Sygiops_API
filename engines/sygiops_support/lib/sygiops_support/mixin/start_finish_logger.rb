module Mixin
  module StartFinishLogger
    extend self
    include ::Mixin::RailsLogger

    def log_start_finish(level, prefix)
      logger.public_send(level, "#{prefix} started.")
      yield
      logger.public_send(level, "#{prefix} finished.")
    end

  end
end
