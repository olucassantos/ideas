#encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery

  def not_found
  	raise ActionController::RoutingError.new('Not Found')
  end

  def logged?
    if !session[:id]
      redirect_to "/entrar"
      flash[:notice] = "Você está logado?"
    end
  end

  def admin?
    if session[:kind] != 2
      redirect_to "/"
      flash[:notice]="Você não é administrador do site."
    end
  end

  def admin_session?
    session[:kind]==2
  end

  def current_user
    User.find(session[:id])
  end
end
