class RoomUser < ApplicationRecord
  validates_presence_of :wish, message: I18n.t('wish_blank')
  validates :real_username, format: { with: /\A[А-Яа-яA-Za-z]+\s*[А-Яа-яA-Za-z]*\z/, message: I18n.t('real_unc') }
end
