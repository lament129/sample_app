class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  $bloom = ["ブ", "ﾌﾞ"]
end
