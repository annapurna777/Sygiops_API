module SygiopsSupport
  class Group < ApplicationRecord
    has_many :tickets
  end
end
