class User < ApplicationRecord
  has_secure_password
  validates_uniqueness_of :username, message: 'Имя пользователя уже существует'
  validates_presence_of :username, message: 'Имя пользователя не должно быть пустым'
  validates_presence_of :password_digest, message: 'Пароль пользователя не должно быть пустым'
  validates :user_mail, format: { with: /\A\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*\z/, message: 'Неверный email' }
  validates_confirmation_of :password
end
