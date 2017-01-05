class UserSkillsController < ApplicationController
  before_action :authenticate

  def create
    user_skill = @current_user.user_skills.new user_skill_params
    if user_skill.save
      render json: user_skill, status: :created
    else
      render json: user_skill.errors.full_messages.first, status: 422
    end
  end

  protected
    def user_skill_params
      params.require(:user_skill).permit(:skill_id, :level)
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
