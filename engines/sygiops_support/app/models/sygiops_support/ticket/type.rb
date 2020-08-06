module SygiopsSupport
class Ticket::Type < ApplicationRecord
  validates :name, presence: true
end
end
