#encoding: utf-8
class LoginController < ApplicationController
  layout "empty"

  def login
    if request.post?
      if session[:id]
        flash[:notice] = "Você ja esta logado, saia antes de entrar com outra conta."
        return
      end

      email = params[:email]
      code  = params[:code]

      if email.blank? && code.blank?
        flash[:notice] = "Informe email e senha"
        return
      end

      if email.blank?
        flash[:notice] = "Informe o email"
        return
      end

      if code.blank?
        flash[:notice] = "Informe a senha"
        return
      end

      user  = User.auth(email,code)
      admin = Admin.auth(email,code)

      if !user && !admin
        flash[:notice] = "Não foi possivel validar seu login."
        return
      end

      session[:id]     = admin ? admin.id   : user.id
      session[:name]   = admin ? admin.name : user.name.split.first
      session[:tested] = admin ? nil : user.tested
      session[:kind]   = admin ? 2 : 1
      redirect_to "/"
    end
  end

  def logout
    [:id,:name,:admin,:kind,:tested].each do |key|
      session[key] = nil
    end
    redirect_to "/"
  end
end
