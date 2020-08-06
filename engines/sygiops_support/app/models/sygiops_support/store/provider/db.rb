# Copyright (C) 2012-2016 Zammad Foundation, http://zammad-foundation.org/
module SygiopsSupport
class Store
  module Provider
    class DB < ApplicationRecord
      self.table_name = 'sygiops_support_store_provider_dbs'

      def self.add(data, sha)
        Store::Provider::DB.create(
          data: data,
          sha:  sha,
        )
        true
      end

      def self.get(sha)
        file = Store::Provider::DB.find_by(sha: sha)
        return if !file

        file.data
      end

      def self.delete(sha)
        Store::Provider::DB.where(sha: sha).destroy_all
        true
      end
    end
  end
end
end
