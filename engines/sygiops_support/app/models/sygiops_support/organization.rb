module SygiopsSupport
  class Organization < ApplicationRecord
    before_create :domain_cleanup
    before_update :domain_cleanup

    validates :name, presence: true
    has_many :members, class_name: 'SygiopsSupport::User'
    has_many :tickets

    private

    def domain_cleanup
      return true if domain.blank?

      domain.gsub!(/@/, '')
      domain.gsub!(/\s*/, '')
      domain.strip!
      domain.downcase!
      true
    end

  end
end
