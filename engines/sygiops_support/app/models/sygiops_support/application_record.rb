module SygiopsSupport
  class ApplicationRecord < ActiveRecord::Base
    
  # include ApplicationRecord::CanActivityStreamLog
  # include ApplicationRecord::HasCache
  # include ApplicationRecord::CanLookup
  # include ApplicationRecord::CanLookupSearchIndexAttributes
  # include ApplicationRecord::ChecksAttributeValuesAndLength
  # include ApplicationRecord::CanCleanupParam
  # include ApplicationRecord::HasRecentViews
  # include ApplicationRecord::ChecksUserColumnsFillup
  # include ApplicationRecord::CanCreatesAndUpdates
  include ApplicationRecord::CanAssets
  include ApplicationRecord::CanAssociations
  include ApplicationRecord::HasAttachments
  # include ApplicationRecord::CanLatestChange
  # include ApplicationRecord::HasExternalSync
  # include ApplicationRecord::ChecksImport
  # include ApplicationRecord::CanTouchReferences
  # include ApplicationRecord::CanQueryCaseInsensitiveWhereOrSql
  # include ApplicationRecord::HasExistsCheckByObjectAndId


    self.abstract_class = true
  end
end
