class SearchController < ApplicationController
  before_action :check, only: :show
  def input; end

  def show
    @inp = params[:n]
    @result = User.where('username LIKE ?', "%#{@inp}%").all
  end

  def add
    @mas = []
    RoomUser.where('user_id = ? AND role = ?', current_user.id, 'admin').all.each do |x|
      @mas.push(Room.find_by(id: x.room_id).room_name)
    end
  end

  def addroom
    id = params[:id]
    roomname = params[:room]
    p RoomUser.where('user_id = ? AND room_id = ?', id, Room.find_by(room_name: roomname).id).empty?
    if !RoomUser.where('user_id = ? AND room_id = ?', id, Room.find_by(room_name: roomname).id).empty?
      redirect_to add_url(id: id), notice: 'пользователь уже в комнате!'
      return
    end
    if Invite.find_by(user_id: id, room_id: Room.find_by(room_name: roomname).id)
      redirect_to add_url(id: id), notice: 'приглашение уже отправлено!'
      return
    end
    @invite = Invite.create(user_id: id, room_id: Room.find_by(room_name: roomname).id, inviter_id: current_user.id)
    redirect_to main_path, notice: 'Пользователь получил ваше приглашение'
  end
end
