require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "register" do
    before do
      @body = {
                user: {
                  email: "user.email@test.com",
                  first_name: "fname",
                  last_name: "lname",
                  password: "123456789"
                }
             }
    end

    context "failure" do
      it "returns email already exists" do
        user = create :user
        @body[:user][:email] = user.email
        post :create, params: @body, format: :json
        expect(response.status).to eq(422)
      end

      it "returns password too short" do
        @body[:user][:password] = "123"
        post :create, params: @body, format: :json
        expect(response.status).to eq(422)
      end

      it "returns missing data" do
        @body[:user][:first_name] = ""
        post :create, params: @body, format: :json
        expect(response.status).to eq(422)
      end
    end

    context "success" do
      it "works fine" do
        post :create, params: @body, format: :json
        expect(response.status).to eq(201)
      end
    end
  end

  describe "login" do
    before do
      user = build :user
      user.password = "123456789"
      user.save!
      @body = {
                user: {
                  email: user.email,
                  password: "123456789"
                }
              }
    end

    it "works fine" do
      post :login, params: @body, format: :json
      expect(response.status).to eq(201)
      expect(response.body["api_key"]).not_to be_blank
    end

    it "fails as wrong password" do
      @body[:user][:password] = "sadhkajshdjkdash"
      post :login, params: @body, format: :json
      expect(response.status).to eq(401)
    end

    it "fails as wrong email" do
      @body[:user][:email] = "n@test.com"
      post :login, params: @body, format: :json
      expect(response.status).to eq(401)
    end
  end

  describe "signout" do
    it "works fine" do
      user = create :user
      @request.headers[:Authorization] = "Token token=#{user.api_key}"
      get :signout
      expect(response.status).to eq(200)
    end
  end
end
