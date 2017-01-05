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
        post :create, @body, format: :json
        expect(response.status).to eq(422)
      end

      it "returns password too short" do
        @body[:user][:password] = "123"
        post :create, @body, format: :json
        expect(response.status).to eq(422)
      end

      it "returns missing data" do
        @body[:user][:first_name] = ""
        post :create, @body, format: :json
        expect(response.status).to eq(422)
      end
    end

    context "succes" do
      it "works fine" do
        post :create, @body, format: :json
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
      post :login, @body, format: :json
      expect(response.status).to eq(201)
      expect(response.body["api_key"]).not_to be_blank
    end

    it "fails as wrong password" do
      @body[:user][:password] = "sadhkajshdjkdash"
      post :login, @body, format: :json
      expect(response.status).to eq(401)
    end

    it "fails as wrong email" do
      @body[:user][:email] = "n@test.com"
      post :login, @body, format: :json
      expect(response.status).to eq(401)
    end
  end
end
