require 'rails_helper'

RSpec.describe Skill, type: :model do
  describe "validation" do
    before :each do
      @skill = build :skill
    end

    it "is happy when all is fine" do
      expect(@skill).to be_valid
    end

    it "checks the presence of name" do
      @skill.name = ""
      expect(@skill).not_to be_valid
      expect(@skill.errors[:name]).to eq(["can't be blank"])
    end

    it "converts the name all downcase" do
      @skill.name = "MUSIC"
      @skill.save
      expect(@skill.name).to eq("music")
    end

    it "cheks uniqueness of name" do
      @skill.save
      new_skill = Skill.new name: @skill.name
      expect(new_skill).not_to be_valid
    end
  end
end
