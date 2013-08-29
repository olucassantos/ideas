# encoding: utf-8
class UsersController < ApplicationController
  layout 'empty'
  respond_to :html
  before_filter :logged?, except: [:create, :new, :confirm, :validated]

  def logged?
    if !session[:id]
      redirect_to "/entrar"
      flash[:notice] = "Você está logado?"
    end
  end

  def index
    if session[:kind] == 2
      @users = User.all
      respond_with @user
    else
        redirect_to "/404"
    end
  end

  def show
    @user = User.find(params[:id]) rescue nil
    if @user
      @theory = @user.theories
      respond_with @user ,@theory
    else
      redirect_to "/404"
    end
  end

  def new
    if session[:kind] == 2 || !session[:kind]
      @user = User.new
      respond_with @user
    else
      if session[:kind == 1]
        redirect_to "/"
        flash[:notice] = "Você já esta cadastrado."
      end
    end
  end

  def edit
    @user = User.find(params[:id]) rescue nil
    if @user
      if session[:tested] == true || session[:kind] == 2
        respond_with @user
      end
    else
      redirect_to "/404"
    end
  end

  def create
    begin
      if session[:kind] == 2 || !session[:kind]
        @user = User.new(params[:user])
        if @user.save
          flash[:notice] = "Usuario Cadastrado"
          generate_token
          @user.save
          Thread.new do
            IdeasMailer.user_created(@user).deliver
          end
          flash[:notice] = "Cadastrado com sucesso. Foi enviado um link de confirmação, em seu e-mail: #{@user.email}."
          redirect_to "/"
        else
          flash[:notice] = "Verifique os dados e tente novamente."
          render action: 'new'
        end
      else
        if session[:kind == 1]
          flash[:notice] = "Você já esta cadastrado."
          redirect_to "/"
        end
      end
      rescue => e
        @user = User.new
        flash[:notice] = e.to_s
        respond_with @user
      end
  end

  def generate_token
   @user.token = Digest::SHA1.hexdigest("fca6652_#{Time.now.to_s + @user.id.to_s}_12vgiodj")
  end

  def update
    begin
      @user = User.find(params[:id])
      flash[:notice] = "Dados atualizados com sucesso." if @user.update_attributes(params[:user])
      respond_with @user
    rescue => e
      @user = User.new
      flash[:notice] =e.to_s
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    flash[:notice] = "Usuario apagado com sucesso" if @user.destroy
    respond_with @user
  end

  def confirm
    @user = User.where(token: "#{params[:token]}")
    if @user == []
      redirect_to "/404"
    else
      user = User.find(@user.first.id)
      user.token = nil
      user.tested = true
      user.save
      flash[:notice]="Cadastro ativado com sucesso"
      if session[:kind] == 1
        logout
      end
      redirect_to "/users/validated"
    end
  end

  def logout
    session[:id] = nil
    session[:name] = nil
    session[:admin] = nil
    session[:status] = nil
    session[:kind] = nil
    session[:tested] = nil
  end

  def sendMail
    @user = User.find(params[:id])
    Thread.new do
        IdeasMailer.user_created(@user).deliver
    end
    redirect_to "/"
  end
end
