class UserSkill
  include Mongoid::Document
  field :user_id, type: String
  field :skill_id, type: String
  field :level, type: Integer
end
