class MainRoomController < ApplicationController
  # before_action :set_room, only: %i[show showroom update destroy]
  def main; end

  def profile; end

  def createroom
    @room = Room.new
  end

  def join; end

  def showroom; end

  def roomjoin
    @rm = Room.where('room_number = ?', params[:number]).take
    if @rm&.authenticate(params[:password])
      if RoomUser.where('room_id = ? AND user_id = ?', @rm.id, current_user.id).take
        redirect_to main_room_join_url, notice: 'юзер уже в комнате'
        return
      end
      @newroom = RoomUser.create
      @newroom.room_id = @rm.id
      @newroom.user_id = current_user.id
      @newroom.role = ActiveSupport::JSON.encode('player')
      @newroom.wish = ActiveSupport::JSON.encode(params[:wish])
      @newroom.real_username = ActiveSupport::JSON.encode(params[:real_username])
      @newroom.save
      redirect_to showroom_url(id: @rm.id), notice: 'вы успешно вступили в комнату'
    else
      redirect_to main_room_join_url, notice: 'неверный номер комнаты или пароль'
    end
  end

  def quit
    RoomUser.where('room_id = ? AND user_id = ?', params[:id], current_user.id).take.destroy
    respond_to do |format|
      format.html { redirect_to profile_url, notice: 'вы успешно вышли из комнаты' }
      format.json { head :no_content }
    end
  end

  # def create
  #   @room = Room.create(room_params)
  #   respond_to do |format|
  #     if @room.save
  #       format.html { redirect_to room_url(@room), notice: 'User was successfully created.' }
  #       # format.json { render :show, status: :created, location: @room }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @room.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

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

  # def room_params
  #   params.require(:user).permit(:room_name, '1', :password, :password_confirmation, current_user["id"], :count_of_users, 'admin', :user_wish)
  # end
end
