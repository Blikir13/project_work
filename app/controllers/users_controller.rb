class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  skip_before_action :require_login, only: %i[create new]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show; end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        sign_in(@user)
        format.html { redirect_to main_path, notice: 'User was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(locale: params[:locale]), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    checkroom(@user)
    respond_to do |format|
      format.html { redirect_to main_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def checkroom(user)
    if (t = RoomUser.where('user_id = ? AND role = ?', user.id, 'admin').all)
      t.each do |x|
        RoomUser.where('room_id = ?', x.room_id).all.each(&:destroy)
        Room.where('id = ?', x.room_id).take.destroy
      end
    end
    if (m = RoomUser.where('user_id = ? AND role = ?', user.id, 'player').take)
      m.destroy
    end
    if (p = Invite.find_by('user_id = ? OR inviter_id = ?', user.id, user.id))
      p.all.each(&:destroy)
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:username, :user_mail, :password, :password_confirmation)
  end
end
