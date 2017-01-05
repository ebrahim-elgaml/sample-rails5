class UsersController < ApplicationController
  before_action :authenticate, only: :signout

  def create
    user = User.new user_params
    if user.save
      render json: user, status: :created
    else
      render json: { message: user.errors.full_messages.first }, status: 422
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

  def signout
    if @current_user.update(api_key: "")
      render json: { message: "success" }, status: :ok
    else
      render json: { message: "something went wrong" }, status: 422
    end
  end

  private
    def user_params
      params.require(:user).permit(
        :first_name, :last_name, :email, :password
      )
    end

    def authenticate
      authenticate_token || render_unauthorized
    end

    def authenticate_token
      authenticate_with_http_token do |token, options|
        @current_user = User.find_by(api_key: token)
      end
    end

    def render_unauthorized
      self.headers['WWW-Authenticate'] = 'Token realm="Application"'
      render json: 'Bad credentials', status: 401
    end
end
