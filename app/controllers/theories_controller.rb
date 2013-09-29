# encoding: utf-8
class TheoriesController < ApplicationController
  layout 'empty'
  require "user"
  respond_to :html
  before_filter :logged? , :except => [:show]
  before_filter :tested_adoption?, only: [:adopt]
  before_filter :tested_abandon?, only: [:abandon]

  def user_find
    User.find(session[:id])
  end

  def adopt
    @theory = Theory.find( params[:id] ) rescue nil
      if !@theory
        redirect_to "/404"
        return
      end

      if @theory.choice == true || @theory.user == current_user
        if @theory.adopted_by?(session[:id]).size>0
          flash[:notice] = "Opa! Você já adotou esta ideia!"
          redirect_to "/users/#{session[:id]}"
          return
        end

        Adoption.create(theory_id: @theory.id,user_id: session[:id])
        redirect_to "/theories/adopted"
      else
        flash[:notice] = "Desculpe, mas o dono da ideia, deseja deixa-la privada."
        redirect_to user_path(session[:id])
      end
  end

  def abandon
    @theory = Theory.find( params[:id] ) rescue nil
    if !@theory
      redirect_to "/404"
      return
    end

    @adoption = @theory.adopted_by?(session[:id])
    if @adoption.size<1
      flash[:notice] = "Opa! você não adotou esta ideia!"
      redirect_to "/users/#{session[:id]}"
      return
    end

    @adoption.first.journals.delete_all if @adoption.first.journals
    @adoption.first.destroy
    flash[:notice] = "Ficamos tristes quando alguem desiste, obrigado por tentar !"
    redirect_to "/theories"
  end

  def index
    @theories = Theory.all
    @categories = Category.all
    respond_with @theory, @categories
  end

  def show
    @theory = Theory.find(params[:id]) rescue nil
    if @theory
      @theory.inc_view
      @theory.save
      respond_with @theory
    else
      redirect_to "/404"
    end
  end

  def new
    if session[:tested] || admin_session?
      @theory = Theory.new
      @users = User.find(:all)
      respond_with @theory
    else
      flash[:notice] = "Você se cadastrou mas ainda não confirmou seu cadastro."
      redirect_to "/users/#{session[:id]}"
    end
  end

  def edit
    @theory = Theory.find(params[:id]) rescue nil
    if @theory
      if @theory.user.id == session[:id] || admin_session?
        @theory = Theory.find(params[:id])
        respond_with @theory
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
      @theory = Theory.new(params[:theory])
      flash[:notice] = "Ideia criada com sucesso!" if @theory.save
      respond_with @theory
      return
    end

   if session[:tested] && !admin_session?
      p '/'*200
      @theory = user_find.theories.new(params[:theory])
      flash[:notice] = "Ideia criada com sucesso!" if @theory.save

      if !@theory.categories.first
        @theory.category_ids = Category.find(6).id
        @theory.save
      end

      respond_with @theory
    else
      flash[:notice] = "Você esta cadastrado mas ainda não esta confirmado."
      redirect_to "/users/#{session[:id]}"
    end
  end

  def user_admin_find
    User.find(params[:id])
  end

  def update
     if session[:tested] || admin_session?
        params[:theory][:category_ids] ||= []
        @theory = Theory.find(params[:id])
        flash[:notice] = "Dados da ideia atualizados com sucesso." if @theory.update_attributes(params[:theory])
        if !@theory.categories.first
          @theory.category_ids = Category.find(6).id
          @theory.save
        end

        respond_with @theory
      else
         flash[:notice] = "Você esta cadastrado mas ainda não esta confirmado."
          redirect_to "/users/#{session[:id]}"
      end
  end

  def destroy
    @theory = Theory.find(params[:id])
    if admin_session? || session[:id] == @theory.user.id
      flash[:notice] = "Infelizmente a ideia foi apagada." if @theory.destroy
      redirect_to "/theories"
    else
      flash[:notice] = "Você não pode apagar uma idea que não te pertence."
      redirect_to "/theories"
    end
  end

  def search
    @search = params[:search]
    @theories = Theory.search params[:search]
  end

  private
  def tested?
    if !session[:tested]
      flash[:notice] = "Você esta cadastrado mas ainda não confirmou seu perfil."
      redirect_to admin_session? ? "/" : "/users/#{session[:id]}"
    end
  end

  def tested_adoption?
    if admin_session?
      flash[:notice] = "Opa! Uma administrador infelizmente não pode adotar uma ideia!"
      redirect_to "/"
      return
    end
    tested?
  end

  def tested_abandon?
    if admin_session?
      flash[:notice] = "Opa! Uma administrador não possui adoções para abandonar!"
      redirect_to "/"
      return
    end
    tested?
  end
end
