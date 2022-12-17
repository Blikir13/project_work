class RoomsController < ApplicationController
  before_action :set_room, only: %i[show edit update destroy]
  before_action :check, only: :create
  def createroom
    @room = Room.new
  end

  def check
    redirect_to main_path, notice: t('.n') unless signed_in?
  end

  def create
    @room = Room.create(room_params)
    @roomuser = RoomUser.create(roomuser_params)
    @roomuser.room_id = @room.id
    @roomuser.user_id = current_user.id
    @roomuser.role = 'admin'
    if @room.save && @roomuser.save
      redirect_to showroom_url(:id => @room.id)
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

  def destroy
    RoomUser.where('room_id = ?', @room.id).all.each(&:destroy)
    @room.destroy
    redirect_to profile_url, notice: 'Room was successfully destroyed.'
    # add_to_history(@room)
  end

  def room_params
    params.require(:room).permit(:room_name, :password, :password_confirmation, 
                                 :count_of_users)
  end

  def roomuser_params
    params.require(:room).permit(:wish, :real_username)
  end
end
