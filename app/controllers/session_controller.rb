class SessionController < ApplicationController
  # skip_before_action :require_login, only: %i[login create]
  # перекус учителя чекни application_controller.rb
  # Так как все контроллеры наследуются от ApplicationController,
  # то перед каждым вызываем проверку на аутентификация,
  # здесь кроме метода логина, а то будет бексонечный редирект
  # и созданию пользователей, все могут создавать их

  def login; end
  # Только отрисовка формы

  def create
    user = User.find_by_username(params[:username])
    if user&.authenticate(params[:password])
      sign_in user # Наш метод входа, описанный в хелпере
      redirect_to main_path
    else
      redirect_to session_login_url, notice: 'неверный логин или пароль'
    end
  end

  def logout
    sign_out # Наш метод выхода, описанный в хелпере
    redirect_to main_path
  end
end
