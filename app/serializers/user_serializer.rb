class UserSerializer < ActiveModel::Serializer
  attributes :_id, :api_key, :email, :first_name, :last_name
end
