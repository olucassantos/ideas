#encoding: utf-8
class AdminsController < ApplicationController
  layout 'empty'
  respond_to :html
  before_filter :logged? , :admin?

  def admin?
    if !session[:kind] == 2 || session[:kind] == 1
      redirect_to "/entrar"
      flash[:notice] ="Você precisa ser um administrador válido para entrar nesta página."
    end
  end

  def logged?
    if !session[:id]
      redirect_to "/entrar"
      flash[:notice] = "Você está logado?"
    end
  end

  def index
    @admins = Admin.all
    respond_with @admin
  end

  def show
    @admin = Admin.find(params[:id]) rescue nil
    if @admin
      respond_with @admin
    else
      redirect_to "/404"
    end
  end

  def new
    @admin = Admin.new
    respond_with @admin
  end

  def edit
    @admin = Admin.find(params[:id]) rescue nil
    if @admin
      respond_with @admin
    else
      redirect_to "/404"
    end
  end

  def create
    begin
      @admin = Admin.new(params[:admin])
      flash[:notice] = "Administrador criado com sucesso." if @admin.save
      respond_with @admin

      rescue => e
          @admin = Admin.new
          flash[:notice] = e.to_s
          render :new
      end
  end

  def update
    begin
    @admin = Admin.find(params[:id])
    flash[:notice] = "Dados atualizados com sucesso." if @admin.update_attributes(params[:admin])
    respond_with @admin

    rescue => e
      @admin = Admin.new
      flash[:notice] =e.to_s
      render :new
    end
  end

  def destroy
    @admin = Admin.find(params[:id])
    flash[:notice] = "Administrador apagado com sucesso." if @admin.destroy
    respond_with @admin
  end
end