class Skill
  include Mongoid::Document
  field :name, type: String, default: ""
  field :_id, type: String, default: ->{ name.to_s.downcase }, overwrite: true

  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :user_skills, dependent: :destroy

  before_validation(on: :create) do
    self.name = name.downcase if name
    self.id = name
  end
end
