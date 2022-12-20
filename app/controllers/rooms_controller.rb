class RoomsController < ApplicationController
  before_action :set_room, only: %i[show edit update destroy add_to_History quit]
  before_action :check, only: :create
  before_action :add_to_History, only: %i[quit destroy]

  def createroom
    @room = Room.new
  end

  def set_room
    @room = Room.find(params[:id])
  end

  def check
    redirect_to main_path, notice: t('.n') unless signed_in?
  end

  def create
    @room = Room.create(room_params)
    if History.find_by(room_name: @room.room_name)
      redirect_to createroom_url, notice: t('.n1')
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
      @room.destroy
      @roomuser.destroy
    end
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
    redirect_to showroom_url, notice: t('.success')
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
    redirect_to profile_url, notice: t('.success')
  end

  def quit
    RoomUser.where('room_id = ? AND user_id = ?', params[:id], current_user.id).take.destroy
    Room.find_by(id: params[:id]).destroy unless RoomUser.where('room_id = ?', params[:id]).take
    redirect_to profile_url, notice: t('.success')
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
    redirect_to showroom_url(id: params[:id]), notice: t('.success')
  end

  def roomjoin
    @rm = Room.where('room_name = ?', params[:room_name]).take
    unless @rm
      redirect_to :join, notice: t('.not_room')
      return
    end
    if RoomUser.find_by(room_id: @rm.id).try(:gift_user_id)
      redirect_to :join, notice: t('.lottery')
      return
    end
    unless RoomUser.find_by(room_id: @rm.id)
      redirect_to :join, notice: t('.lottery')
      return
    end
    if @rm.count_of_users.to_i == RoomUser.where('room_id = ?', @rm.id).all.length
      redirect_to :join, notice: t('.full')
      return
    end
    if @rm&.authenticate(params[:password])
      if RoomUser.where('room_id = ? AND user_id = ?', @rm.id, current_user.id).take
        redirect_to :join, notice: t('.user')
        return
      end
      if (t = Invite.where('room_id = ? AND user_id = ?', @rm.id, current_user.id).take)
        t.destroy
      end
      @newroom = RoomUser.create
      if @newroom.update(room_id: @rm.id, user_id: current_user.id, role: 'player', wish: params[:wish],
                         real_username: params[:real_username])
        redirect_to showroom_url(id: @rm.id), notice: t('.success')
      else
        render 'main_room/join', status: :unprocessable_entity
      end
    else
      redirect_to join_url, notice: t('.password')
    end
  end

  private

  def room_params
    params.require(:room).permit(:room_name, :password, :password_confirmation,
                                 :count_of_users)
  end

  def roomuser_params
    params.require(:room).permit(:wish, :real_username)
  end
end
