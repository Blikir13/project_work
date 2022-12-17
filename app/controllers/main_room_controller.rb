class MainRoomController < ApplicationController
  # before_action :set_room, only: %i[show showroom update destroy]
  before_action :check, only: :roomjoin
  def main; end

  def profile; end

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
      redirect_to main_room_join_url, notice: 'В комнате уже прошел розыгрыш! Ты не можешь в нее вступить!'
      return
    end
    if @rm.count_of_users.to_i == RoomUser.where('room_id = ?', @rm.id).all.length
      redirect_to main_room_join_url, notice: 'Комната полностью заполнена!'
      return
    end
    Invite.where('room_id = ? AND user_id = ?', @rm.id, current_user.id).take.destroy
    @newroom = RoomUser.create
    @newroom.update(room_id: @rm.id, user_id: current_user.id, role: 'player', wish: params[:wish],
                    real_username: params[:real_username])
    redirect_to showroom_url(id: @rm.id), notice: 'вы успешно вступили в комнату!'
  end

  def reject_invite
    Invite.where('room_id = ? AND user_id = ?', Room.where('id = ?', params[:id]).take.id, current_user.id).take.destroy
    redirect_to profile_url(id: Room.where('id = ?', params[:id]).take.id), notice: 'вы успешно отклонили приглашение!'
  end

  def roomjoin
    @rm = Room.where('room_name = ?', params[:room_name]).take
    unless @rm
      redirect_to :join, notice: 'Комнаты с таким именем не существует!'
      return
    end
    if RoomUser.find_by(room_id: @rm.id).gift_user_id
      redirect_to :join, notice: 'В комнате уже прошел розыгрыш! Ты не можешь в нее вступить!'
      return
    end
    if @rm.count_of_users.to_i == RoomUser.where('room_id = ?', @rm.id).all.length
      redirect_to :join, notice: 'Комната полностью заполнена!'
      return
    end
    if @rm&.authenticate(params[:password])
      if RoomUser.where('room_id = ? AND user_id = ?', @rm.id, current_user.id).take
        redirect_to :join, notice: 'юзер уже в комнате!'
        return
      end
      if (t = Invite.where('room_id = ? AND user_id = ?', @rm.id, current_user.id).take)
        t.destroy
      end
      @newroom = RoomUser.create
      @newroom.update(room_id: @rm.id, user_id: current_user.id, role: 'player', wish: params[:wish],
                      real_username: params[:real_username])
      redirect_to showroom_url(id: @rm.id), notice: 'вы успешно вступили в комнату!'
    else
      redirect_to main_room_join_url, notice: 'неверный пароль!'
    end
  end

  def quit
    RoomUser.where('room_id = ? AND user_id = ?', params[:id], current_user.id).take.destroy
    respond_to do |format|
      format.html { redirect_to profile_url, notice: 'вы успешно вышли из комнаты' }
    end
  end

  def deleteuser
    p params[:id]
    RoomUser.where('user_id = ?', params[:id]).take.destroy
    respond_to do |format|
      format.html { redirect_to showroom_url, notice: 'вы успешно удалили человека из комнаты!' }
    end
  end

  def lottery
    a = []
    RoomUser.where('room_id = ?', params[:id]).all.each { |x| a.push(x.user_id) }
    a.shuffle!.push(a[0]).each_with_index do |el, index|
      unless index == a.length - 1
        RoomUser.find_by(user_id: el,
                         room_id: params[:id]).update(gift_user_id: a[index + 1])
      end
    end
    redirect_to showroom_url, notice: 'вы успешно удалили человека из комнаты!'
  end

  def accept_invite; end

  def set_room
    @room = Room.find(params[:id])
  end

  def destroyroom
    RoomUser.where('room_id = ?', @room.id).all.destroy
    @room.destroy
    respond_to do |format|
      format.html { redirect_to profile, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
end
