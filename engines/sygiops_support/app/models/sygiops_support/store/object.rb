# Copyright (C) 2012-2016 Zammad Foundation, http://zammad-foundation.org/
module SygiopsSupport
class Store < ApplicationRecord
  class Object < ApplicationRecord
    validates :name, presence: true
  end
end
end
