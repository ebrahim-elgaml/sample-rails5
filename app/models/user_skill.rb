class UserSkill
  include Mongoid::Document
  field :user_id, type: String
  field :skill_id, type: String
  field :level, type: Integer

  validates :skill_id, uniqueness: { scope: [:user_id] }
  validates_inclusion_of :level, in: 1..5, message: "is not between 1 and 5"

  belongs_to :user, index: true
  belongs_to :skill, index: true

end
