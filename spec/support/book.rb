class Book
  include Mongoid::Document
  include Vidibus::Versioning::Mongoid
  include Vidibus::VersionScheduler::Mongoid

  field :title, :type => String
  field :text, :type => String

  validates :title, :presence => true
end
