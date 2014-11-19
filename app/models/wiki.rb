class Wiki
  include Mongoid::Document

  require "bson"
  require "moped"

  Moped::BSON = BSON

  field :subject, type: String
  field :body, type: String
  field :privacy, type: String, default: 'Public'
  #field :author, type: Moped::BSON::ObjectId
  field :collaborators, type: Array

  belongs_to :author, class_name: "User"
  #has_and_belongs_to_many :users, :as => :collaborated_wikis

end
