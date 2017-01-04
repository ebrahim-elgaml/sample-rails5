require 'securerandom'
class User
  include Mongoid::Document

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  field :email, type: String, default: ""
  field :first_name, type: String, default: ""
  field :last_name, type: String, default: ""
  field :api_key, type: String, default: ""
  field :encrypted_password, type: String, default: ""
  field :reset_password_token, type: String
  field :reset_password_sent_at, type: Time
  field :remember_created_at, type: Time
  field :sign_in_count, type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at, type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip, type: String

  before_create :set_token

  private
    def set_token
      loop do
        token = SecureRandom.base64.tr('+/=', 'Qrt')
        break token unless User.exists?(api_key: token)
      end
    end
end
