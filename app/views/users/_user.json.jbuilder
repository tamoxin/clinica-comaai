json.extract! user, :id, :username, :password, :userType, :firstName, :lastName, :email, :phone, :active, :created_at, :updated_at
json.url user_url(user, format: :json)
