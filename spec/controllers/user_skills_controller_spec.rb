require 'rails_helper'

RSpec.describe UserSkillsController, type: :controller do
  describe "user add skill" do
    before do
      @user = create :user
      @skill = create :skill
      @request.headers[:Authorization] = "Token token=#{@user.api_key}"
      @body = {
        user_skill: {
          skill_id: @skill.name,
          level: 3
        }
      }
    end

    context "success" do
      it "works fine" do
        post :create, @body, format: :json
        expect(response.status).to eq(201)
      end
    end

    context "failure" do
      it "finds another record" do
        UserSkill.create! user: @user.id, skill: @skill, level: 2
        post :create, @body, format: :json
        expect(response.status).to eq(422)
      end

      it "exceeds level range" do
        @body[:user_skill][:level] = 7
        post :create, @body, format: :json
        expect(response.status).to eq(422)
      end
    end
  end

  describe "search" do
    before do
      user = create :user
      @skill = create :skill
      UserSkill.create skill: @skill, user: create(:user)
      UserSkill.create skill: @skill, user: create(:user)
      UserSkill.create skill: @skill, user: create(:user)
      UserSkill.create skill: @skill, user: create(:user)
      @request.headers[:Authorization] = "Token token=#{user.api_key}"
    end

    it "finds users" do
      get :search, { q: @skill.name }
      expect(response.status).to eq(200)
      expect(response.body.count).to eq(4)
    end

    it "finds no user" do
      get :search, { q: "dskaj-1"}
      expect(response.status).to eq(422)
    end
  end
end
