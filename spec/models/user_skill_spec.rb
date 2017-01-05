require 'rails_helper'

RSpec.describe UserSkill, type: :model do
  describe "validation" do
    before :each do
      skill = create :skill
      user = create :user
      @user_skill = UserSkill.new skill: skill, user: user, level: 1
    end

    it "is happy when all is fine" do
      expect(@user_skill).to be_valid
    end

    it "checks the presence of level" do
      @user_skill.level = ""
      expect(@user_skill).not_to be_valid
    end

    it "cheks range of level less than 5" do
      @user_skill.level = 7
      expect(@user_skill).not_to be_valid
    end

    it "cheks range of level more than than 1" do
      @user_skill.level = 0
      expect(@user_skill).not_to be_valid
    end
  end
end
