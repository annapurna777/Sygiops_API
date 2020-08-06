# Copyright (C) 2018 Zammad Foundation, http://zammad-foundation.org/
module SygiopsSupport
  module Concerns
module HasObjectManagerAttributesValidation
  extend ActiveSupport::Concern

  # included do
  #   include ActiveModel::Validations
  #   validates_with ObjectManager::Attribute::Validation, on: %i[create update]
  # end
end
end
end
