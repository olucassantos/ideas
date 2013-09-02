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

      user = User.auth(email, code)
      admin = Admin.auth(email,code)

      if !user
        kind = nil
        if !admin
          kind = nil
          flash[:notice] = "Não foi possivel validar seu login."
        end
      end

      if user
        kind = 1
      end

        if admin
          kind = 2
        end

      if  kind == 2
        session[:id] = admin.id
        session[:name] = admin.name
        session[:status] = admin.status
        session[:kind] = 2
        redirect_to "/entrar"
      end

      if  kind == 1
        session[:id] = user.id
        session[:name] = user.name
        session[:tested] = user.tested
        session[:kind] = 1
        redirect_to "/"
      end

    end
  end

  def logout
    session[:id] = nil
    session[:name] = nil
    session[:admin] = nil
    session[:status] = nil
    session[:kind] = nil
    session[:tested] = nil
    redirect_to "/"
  end
end