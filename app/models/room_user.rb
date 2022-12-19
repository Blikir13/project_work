class RoomUser < ApplicationRecord
  validates_presence_of :wish, message: 'Пожелание не должно быть пустым'
end
