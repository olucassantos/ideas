#encoding: utf-8
class IdeasMailer < ActionMailer::Base
  default from: "mailer.idea.system@gmail.com"
  def user_created(user)
    @dados = user
    mail to: "#{@dados.email}", subject: "Usuario criado"
  end
end
