class Room < ApplicationRecord
  has_secure_password
  validates_uniqueness_of :room_name, message: I18n.t('m2')
  validates_presence_of :room_name, message: I18n.t('m1')
  validates_presence_of :password_digest, message: I18n.t('m3')
  validates_confirmation_of :password
  validates :count_of_users, format: { with: /\A[3-9]{1}\z|\A[1-9]+\d+\z/, message: I18n.t('m4') }
end
