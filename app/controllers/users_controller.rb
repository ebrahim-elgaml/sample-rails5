class UsersController < ApplicationController

  def create
    user = User.new user_params
    if user.save
      render json: user, status: :created
    else
      render json: user.errors.full_messages.first, status: 422
    end
  end

  def login
    user = User.where(id: user_params[:email])
    if user.exists?
      user = user.to_a.first
      if user.valid_password? user_params[:password]
        user.set_token
        user.save
        render json: user, status: :created
      else
        render json: { message: "Invalid email or password" }, status: :unauthorized
      end
    else
      render json: { message: "Invalid email or password" }, status: :unauthorized
    end
  end

  private
    def user_params
      params.require(:user).permit(
        :first_name, :last_name, :email, :password
      )
    end
end
