class Url
  include Mongoid::Document
  include Mongoid::Timestamps
  field :original_url, type: String
  field :short_url, type: String
  field :expire_at, type: DateTime
  validates_uniqueness_of :short_url
end
