require 'rails_helper'

RSpec.describe User, type: :model do

  describe "validation" do
    before :each do
      @user = build :user
    end

    it "is happy when all is fine" do
      expect(@user).to be_valid
    end

    it "is has api_key" do
      @user.save!
      expect(@user.reload.api_key).not_to be_blank
    end

    it "checks the presence of a first_name" do
      @user.first_name = ""
      expect(@user).not_to be_valid
      expect(@user.errors[:first_name]).to eq(["can't be blank"])
    end

    it "checks the presence of a last_name" do
      @user.last_name = ""
      expect(@user).not_to be_valid
      expect(@user.errors[:last_name]).to  eq(["can't be blank"])
    end

    it "converts the email all downcase" do
      @user.email = "EEEE@TEST.com"
      @user.save
      expect(@user.email).to eq("eeee@test.com")
    end
  end
end
