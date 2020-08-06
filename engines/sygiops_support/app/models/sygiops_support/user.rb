module SygiopsSupport
  class User < ApplicationRecord
    has_many :groups
    has_one :role
    belongs_to  :organization,   inverse_of: :members, optional: true
  end
end
