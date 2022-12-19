class SessionController < ApplicationController
  skip_before_action :require_login, only: %i[login create]
  def login; end

  def create
    user = User.find_by_username(params[:username])
    if user&.authenticate(params[:password])
      sign_in user 
      redirect_to main_path
    else
      redirect_to session_login_url, notice: t('.error')
    end
  end

  def logout
    sign_out
    redirect_to main_path
  end
end
