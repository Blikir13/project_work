class ApplicationController < ActionController::Base
  include SessionHelper

  # before_action :require_login

  def check
    redirect_to main_path, notice: 'вы не авторизированы!' unless signed_in?
  end
  
  def require_login
    redirect_to session_login_url unless signed_in?
  end
end
