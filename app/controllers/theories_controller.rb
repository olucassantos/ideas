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

    if session[:tested]
      @theory = Theory.find( params[:id] ) rescue nil
      if !@theory
        redirect_to "/404"
        return
      end

      @a ||= []
      @a = Adoption.where("user_id == #{session[:id]}").where("theory_id == #{@theory.id}")
      if @a == []
        @adoption = true
      else
        @adoption = false
      end

      if @adoption == false
        flash[:notice] = "Opa! Você já adotou esta ideia!"
        redirect_to "/users/#{session[:id]}"
        return
      end

        Adoption.create(theory_id: @theory.id,user_id: session[:id])
        redirect_to "/theories/adopted"
    end
  end

  def abandon
    if session[:tested]
      @theory = Theory.find( params[:id] ) rescue nil
      if !@theory
        redirect_to "/404"
        return
      end

      @a ||= []
      @a = Adoption.where("user_id == #{session[:id]}").where("theory_id == #{@theory.id}")
      if @a == []
        @adoption = false
      else
        @adoption = true
      end

      if !@adoption
        flash[:notice] = "Opa! você não adotou esta ideia!"
        redirect_to "/users/#{session[:id]}"
        return
      end
        @a.first.journals.delete_all if @a.first.journals
        @a.first.destroy
        flash[:notice] = "Ficamos tristes quando alguem desiste, obrigado por tentar !"
        redirect_to "/theories"
    end
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
      if session[:kind] == 2
        flash[:notice] = "Porque diabos um administrador iria criar uma ideia para um usuario?"
        redirect_to "/"
      return
    end

    if session[:tested] || session[:kind] == 2
      @theory = Theory.new
      respond_with @theory
    else
      flash[:notice] = "Você esta cadastrado mas ainda não esta confirmado."
      redirect_to "/users/#{session[:id]}"
    end
  end

  def edit
    @theory = Theory.find(params[:id]) rescue nil
    if @theory
      if @theory.user.id == session[:id] || session[:kind] == 2
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
   if session[:kind] == 2
      flash[:notice] = "Porque diabos um administrador iria criar uma ideia para um usuario?"
      redirect_to "/"
      return
    end

   if session[:tested] && session[:kind] == 1
      @theory = user_find.theories.new(params[:theory])
      flash[:notice] = "Ideia criada com sucesso!" if @theory.save
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
     if session[:tested] || session[:kind] == 2
        params[:theory][:category_ids] ||= []
        @theory = Theory.find(params[:id])
        flash[:notice] = "Dados da ideia atualizados com sucesso." if @theory.update_attributes(params[:theory])
        respond_with @theory
      else
         flash[:notice] = "Você esta cadastrado mas ainda não esta confirmado."
          redirect_to "/users/#{session[:id]}"
      end
  end

  def destroy
    @theory = Theory.find(params[:id])
    if session[:kind] == 2 || session[:id] == @theory.user.id
      flash[:notice] = "Infelizmente a ideia foi apagada." if @theory.destroy
      redirect_to "/theories"
    else
      flash[:notice] = "Você não pode apagar uma idea que não te pertence."
      redirect_to "/theories"
    end
  end

  private
  def tested?
    if !session[:tested]
      flash[:notice] = "Você esta cadastrado mas ainda não confirmou seu perfil."
      redirect_to session[:kind]==2 ? "/" : "/users/#{session[:id]}"
    end
  end

  def tested_adoption?
    if session[:kind]==2
      flash[:notice] = "Opa! Uma administrador infelizmente não pode adotar uma ideia!"
      redirect_to "/"
      return
    end
    tested?
  end

  def tested_abandon?
    if session[:kind]==2
      flash[:notice] = "Opa! Uma administrador não possui adoções para abandonar!"
      redirect_to "/"
      return
    end
    tested?
  end
end
