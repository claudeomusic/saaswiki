class Wiki
  include Mongoid::Document

  require "bson"
  require "moped"

  Moped::BSON = BSON

  field :subject, type: String
  field :body, type: String
  field :author, type: Moped::BSON::ObjectId
  field :collaborators, type: Array

  has_and_belongs_to_many :users

end
