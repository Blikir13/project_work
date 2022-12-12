class Room < ApplicationRecord
  has_secure_password
  validates_uniqueness_of :room_name, message: 'Имя пользователя уже существует'
  validates_presence_of :room_name, message: 'Имя пользователя не должно быть пустым'
  validates_presence_of :password_digest, message: 'Пароль пользователя не должно быть пустым'
  validates_confirmation_of :password
end
