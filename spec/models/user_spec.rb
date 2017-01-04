require 'rails_helper'

RSpec.describe User, type: :model do

  describe "validation" do
    before :each do
      @user = build :user
    end

    it "is happy when all is fine" do
      @user.should be_valid
    end

    it "is has api_key" do
      @user.save
      @user.api_key.should_not be_blank
    end

    it "checks the presence of a first_name" do
      @user.first_name = ""
      @user.should_not be_valid
      @user.errors[:first_name].should == ["can't be blank"]
    end

    it "checks the presence of a last_name" do
      @user.last_name = ""
      @user.should_not be_valid
      @user.errors[:last_name].should == ["can't be blank"]
    end

    it "converts the email all downcase" do
      @user.email = "EEEE@TEST.com"
      @user.save
      @user.email.should == "eeee@test.com"
    end
  end
end
