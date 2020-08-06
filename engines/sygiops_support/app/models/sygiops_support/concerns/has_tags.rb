# Copyright (C) 2012-2016 Zammad Foundation, http://zammad-foundation.org/
module SygiopsSupport
  module Concerns
module HasTags
  extend ActiveSupport::Concern

  included do
    # before_destroy :tag_destroy
  end

=begin

add an tag to model

  model = Model.find(123)
  model.tag_add(name)

=end

  def tag_add(name, current_user_id = nil)
    Tag.tag_add(
      object:        self.class.to_s,
      o_id:          id,
      item:          name,
    )
  end

=begin

remove an tag of model

  model = Model.find(123)
  model.tag_remove(name)

=end

  def tag_remove(name, current_user_id = nil)
    Tag.tag_remove(
      object:        self.class.to_s,
      o_id:          id,
      item:          name,
    )
  end

=begin

tag list of model

  model = Model.find(123)
  tags = model.tag_list

=end

  def tag_list
    Tag.tag_list(
      object: self.class.to_s,
      o_id:   id,
    )
  end

=begin

destroy all tags of an object

  model = Model.find(123)
  model.tag_destroy

=end

  def tag_destroy(current_user_id = nil)
    Tag.tag_destroy(
      object:        self.class.to_s,
      o_id:          id,
    )
    true
  end

end
end
end
