# Copyright (C) 2012-2016 Zammad Foundation, http://zammad-foundation.org/
module SygiopsSupport
class Ticket::Article::Type < ApplicationRecord
  # include Concerns::ChecksLatestChangeObserved
  # include Concerns::HasCollectionUpdate

  validates :name, presence: true
end
end
