class User < ApplicationRecord
  has_secure_password
  validates_uniqueness_of :username, message: I18n.t('user_exist')
  validates_presence_of :username, message: I18n.t('user_blank')
  validates_presence_of :password_digest, message: I18n.t('pass_blank')
  validates :user_mail, format: { with: /\A\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*\z/, message: I18n.t('email_unc') }
  validates_confirmation_of :password
end
