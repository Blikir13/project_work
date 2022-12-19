class RoomsController < ApplicationController
  before_action :set_room, only: %i[show edit update destroy add_to_History quit]
  before_action :check, only: :create
  before_action :add_to_History, only: %i[quit destroy]

  def createroom
    @room = Room.new
  end

  def check
    redirect_to main_path, notice: t('.n') unless signed_in?
  end

  def create
    @room = Room.create(room_params)
    if History.find_by(room_name: @room.room_name)
      redirect_to createroom_url, notice: 'Комната с таким именем уже существует'
      return
    end
    @roomuser = RoomUser.create(roomuser_params)
    @roomuser.room_id = @room.id
    @roomuser.user_id = current_user.id
    @roomuser.role = 'admin'
    if @room.save && @roomuser.save
      redirect_to showroom_url(id: @room.id)
    else
      render 'rooms/createroom', status: :unprocessable_entity
    end
  end

  def set_room
    @room = Room.find(params[:id])
  end

  def edit; end

  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to :profile, notice: t('.not') }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def deleteuser
    RoomUser.where('user_id = ? AND room_id = ?', params[:uid], params[:id]).take.destroy
    redirect_to showroom_url, notice: 'вы успешно удалили человека из комнаты!'
  end

  def add_to_History
    if RoomUser.where('room_id = ?', @room.id).take.gift_user_id && !History.where('room_name = ?', @room.room_name)
      RoomUser.where('room_id = ?',
                     @room.id).all.each do |el|
        History.create(giver_name: el.real_username,
                       giver_id: el.user_id,
                       receiver_id: RoomUser.find_by('user_id = ? AND room_id = ?', el.gift_user_id,
                                                     el.room_id).user_id,
                       receiver_name: RoomUser.find_by('user_id = ? AND room_id = ?', el.gift_user_id,
                                                       el.room_id).real_username,
                       receiver_wish: RoomUser.find_by(user_id: el.gift_user_id, room_id: el.room_id).wish,
                       room_name: Room.find_by(id: el.room_id).room_name)
      end
    end
  end

  def destroy
    RoomUser.where('room_id = ?', @room.id).all.each(&:destroy)
    @room.destroy
    redirect_to profile_url, notice: 'Room was successfully destroyed.'
  end

  def quit
    RoomUser.where('room_id = ? AND user_id = ?', params[:id], current_user.id).take.destroy
    unless RoomUser.where('room_id = ?', params[:id]).take
      Room.find_by(id: params[:id]).destroy
    end
    redirect_to profile_url, notice: 'вы успешно вышли из комнаты'
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

  private

  def room_params
    params.require(:room).permit(:room_name, :password, :password_confirmation,
                                 :count_of_users)
  end

  def roomuser_params
    params.require(:room).permit(:wish, :real_username)
  end

  def return_room
    params.require(:room).permit(:room_name)
  end
end
