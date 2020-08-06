module SygiopsSupport
  class Role < ApplicationRecord
    validates :name, presence: true
  end
end
