class Wiki
  include Mongoid::Document
  field :subject, type: String
  field :body, type: String
  has_and_belongs_to_many :users

end
