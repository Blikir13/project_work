class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

  def tmail
    mail(to: 'KirillTatarenko03@yandex.ru', subject: 'Welcome to My Awesome Site')
  end
end
