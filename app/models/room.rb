class Room < ApplicationRecord
  has_secure_password
  validates_uniqueness_of :room_name, message: 'Имя комнаты уже существует'
  validates_presence_of :room_name, message: 'Имя комнаты не должно быть пустым'
  validates_presence_of :password_digest, message: 'Пароль не должно быть пустым'
  validates_confirmation_of :password
  validates :count_of_users, format: { with: /\A[1-9]\d*\z/, message: 'Неверное количество человек' }
end
