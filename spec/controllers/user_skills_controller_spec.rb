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
        expect(response.status).to eq(200)
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
end
