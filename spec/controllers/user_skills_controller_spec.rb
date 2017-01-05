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
      it "adds already existing skill" do
        post :create, params: @body, format: :json
        expect(response.status).to eq(201)
      end

      it "adds new skill" do
        @body[:user_skill][:skill_id] = "dancing"
        post :create, params: @body, format: :json
        expect(response.status).to eq(201)
      end
    end

    context "failure" do
      it "finds another record" do
        UserSkill.create! user: @user.id, skill: @skill, level: 2
        post :create, params: @body, format: :json
        expect(response.status).to eq(422)
      end

      it "exceeds level range" do
        @body[:user_skill][:level] = 7
        post :create, params: @body, format: :json
        expect(response.status).to eq(422)
      end
    end
  end

  describe "search" do
    before do
      user = create :user
      @skill = create :skill
      @user1 = create :user
      @user2 = create :user
      @user3 = create :user
      @user4 = create :user
      UserSkill.create! skill: @skill, user: @user1, level: 1
      UserSkill.create! skill: @skill, user: @user2, level: 1
      UserSkill.create! skill: @skill, user: @user3, level: 1
      UserSkill.create! skill: @skill, user: @user4, level: 1
      @request.headers[:Authorization] = "Token token=#{user.api_key}"
    end

    it "finds users" do
      get :search, params: { q: @skill.name }
      expect(response.status).to eq(200)
      expect(response.body).to include(@user1.to_json)
      expect(response.body).to include(@user2.to_json)
      expect(response.body).to include(@user3.to_json)
      expect(response.body).to include(@user4.to_json)
    end

    it "finds no user" do
      get :search, params: { q: "dskaj-1"}
      expect(response.status).to eq(200)
      expect(response.body).to eq("[]")
    end

    it "fails" do
      get :search
      expect(response.status).to eq(422)
    end
  end
end
