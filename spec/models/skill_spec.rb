require 'rails_helper'

RSpec.describe Skill, type: :model do
  describe "validation" do
    before :each do
      @skill = build :skill
    end

    it "is happy when all is fine" do
      @skill.should be_valid
    end

    it "checks the presence of name" do
      @skill.name = ""
      @skill.should_not be_valid
      @skill.errors[:name].should == ["can't be blank"]
    end

    it "converts the name all downcase" do
      @skill.email = "MUSIC"
      @skill.save
      @skill.email.should == "music"
    end

    it "cheks uniqueness of email" do
      @skill.save
      new_skill = Skill.new name: @skill.name
      new_skill.should_not be_valid
    end
  end
end
