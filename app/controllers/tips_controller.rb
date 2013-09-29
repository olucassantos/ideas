# encoding: utf-8
class TipsController < ApplicationController
  layout 'empty'
  respond_to :html

  before_filter :logged? , :except => [:show]

  def index
    @tips = Tip.all
    @categories = Category.all
  end

  def show
    @tip = Tip.find(params[:id]) rescue nil
    if @tip
      @tip.inc_view
      @tip.save
      respond_with @tip
    else
      redirect_to "/404"
    end
  end

  def new
    if session[:tested] || admin_session?
      @tip = Tip.new
      @users = User.find(:all)
      respond_with @tip
    else
      flash[:notice] = "Você se cadastrou mas ainda não confirmou seu cadastro."
      redirect_to "/users/#{session[:id]}"
    end
  end

  def edit
    @tip = Tip.find(params[:id]) rescue nil
    if @tip
      if @tip.user.id == session[:id] || admin_session?
        @tip = Tip.find(params[:id])
        respond_with @tip
      else
        flash[:notice] = "Essa historia não é de sua propriedade, então voce não pode altera-la"
        redirect_to "/"
      end
    else
      redirect_to "/404"
    end
  end

  def create
   if admin_session?
      @tip = Tip.new(params[:tip])
      flash[:notice] = "Dica criada com sucesso!" if @tip.save
      respond_with @tip
      return
    end

   if session[:tested] && !admin_session?
      @tip = current_user.tips.new(params[:tip])
      flash[:notice] = "Ideia criada com sucesso!" if @tip.save
      respond_with @tip
    else
      flash[:notice] = "Você esta cadastrado mas ainda não esta confirmado."
      redirect_to "/users/#{session[:id]}"
    end
  end

  def destroy
    @tip = Tip.find(params[:id])
    if admin_session? || session[:id] == @tip.user.id
      flash[:notice] = "Infelizmente a ideia foi apagada." if @tip.destroy
      redirect_to "/tips"
    else
      flash[:notice] = "Você não pode apagar uma idea que não te pertence."
      redirect_to "/tips"
    end
  end

  def update
     if session[:tested] || admin_session?
        @tip = Tip.find(params[:id])
        flash[:notice] = "Dados da ideia atualizados com sucesso." if @tip.update_attributes(params[:tip])
        respond_with @tip
      else
         flash[:notice] = "Você esta cadastrado mas ainda não esta confirmado."
         redirect_to "/users/#{session[:id]}"
      end
  end

end