class MainRoomController < ApplicationController
  skip_before_action :require_login, only: :main
  before_action :check, only: :roomjoin
  def main; end

  def profile; end

  def show
    @res = History.where('receiver_id = ?', current_user.id).all
  end

  def createroom
    redirect_to main_path, notice: t('.n') unless signed_in?
    @room = Room.new
  end

  def check
    redirect_to main_path, notice: t('.n') unless signed_in?
  end

  def join; end

  def showroom; end

  def roomjoininvite
    @rm = Room.where('id = ?', params[:id]).take
    if RoomUser.find_by(room_id: @rm.id).gift_user_id
      redirect_to main_room_join_url, notice: t('.lottery')
      return
    end
    if @rm.count_of_users.to_i == RoomUser.where('room_id = ?', @rm.id).all.length
      redirect_to main_room_join_url, notice: t('.full')
      return
    end
    Invite.where('room_id = ? AND user_id = ?', @rm.id, current_user.id).take.destroy
    @newroom = RoomUser.create
    @newroom.update(room_id: @rm.id, user_id: current_user.id, role: 'player', wish: params[:wish],
                    real_username: params[:real_username])
    redirect_to showroom_url(id: @rm.id), notice: t('.success')
  end

  def reject_invite
    Invite.where('room_id = ? AND user_id = ?', Room.where('id = ?', params[:id]).take.id, current_user.id).take.destroy
    redirect_to profile_url(id: Room.where('id = ?', params[:id]).take.id), notice: t('.reject')
  end

  def accept_invite; end

  def set_room
    @room = Room.find(params[:id])
  end
end
