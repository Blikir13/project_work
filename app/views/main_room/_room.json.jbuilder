json.extract! room, :id, :room_name, :room_number, :password_digest, :user_if, :count_of_users, :role, :user_wish, :created_at, :updated_at
json.url room_url(room, format: :json)
