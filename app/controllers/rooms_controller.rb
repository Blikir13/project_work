class RoomsController < ApplicationController
  before_action :set_room, only: %i[show edit update destroy]
  def createroom
    @room = Room.new
  end

  def create
    @room = Room.create(room_params)
    @room.room_number = ActiveSupport::JSON.encode(23)
    @roomuser = RoomUser.create(roomuser_params)
    @roomuser.room_id = @room.id
    @roomuser.user_id = current_user.id
    @roomuser.role = ActiveSupport::JSON.encode('admin')
    respond_to do |format|
      if @room.save && @roomuser.save
        format.html { redirect_to room_url(@room), notice: 'Room was successfully created.' }
        format.json { render :showroom, status: :created, location: @room }
      else
        format.html { render 'rooms/createroom', status: :unprocessable_entity }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  def set_room
    @room = Room.find(params[:id])
  end

  def destroy
    p @room.id
    RoomUser.find_by_room_id(@room.id).destroy
    @room.destroy
    respond_to do |format|
      format.html { redirect_to profile_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def room_params
    params.require(:room).permit(:room_name, :password, :password_confirmation, 
                                 :count_of_users)
  end

  def roomuser_params
    params.require(:room).permit(:wish, :real_username)
  end
end
