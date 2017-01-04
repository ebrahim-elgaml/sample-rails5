require 'rails_helper'

RSpec.describe UserSkill, type: :model do
  describe "validation" do
    before :each do
      skill = create :skill
      user = create :user
      @user_skill = UserSkill.new skill: skill, user: user, level: 1
    end

    it "is happy when all is fine" do
      @user_skill.should be_valid
    end

    it "checks the presence of level" do
      @user_skill.name = ""
      @user_skill.should_not be_valid
      @user_skill.errors[:level].should == ["can't be blank"]
    end

    it "cheks range of level less than 5" do
      @user_skill.level = 7
      @user_skill.should_not be_valid
    end

    it "cheks range of level more than than 1" do
      @user_skill.level = 0
      @user_skill.should_not be_valid
    end
  end
end
