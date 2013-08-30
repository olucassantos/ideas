# encoding: utf-8
class JournalsController < ApplicationController
  layout 'empty'
  respond_to :html

  before_filter :logged?

  def logged?
    if !session[:id]
      redirect_to "/entrar"
      flash[:notice] = "Você está logado?"
    end
  end

  def owner
    User.find(session[:id])
  end

  def index
    if session[:kind] == 2
      @journals = Journal.all
      respond_with @journals
    else
      redirect_to "/404"
    end
  end

  def show
    @journal = Journal.find(params[:id]) rescue nil
    if @journal
      respond_with @journal
    else
      redirect_to "/404"
    end
  end

  def new
    @adoption = Adoption.find(params[:id]) if params[:id]
    if @adoption
      if @adoption.user == owner
        @journal = @adoption.journals.new
        respond_with @journal
      else
        flash[:notice] = "Você não pode alterar um diário que não te pertence."
        redirect_to "/users/#{session[:id]}"
      end
    else
      redirect_to "/users/#{session[:id]}"
    end
  end

  def edit
    @journal = Journal.find(params[:id]) rescue nil
      if @journal
          if @journal.adoption.user == owner
            respond_with @journal
            else
              flash[:notice] = "Você não pode alterar um diário que não te pertence."
              redirect_to "/users/#{session[:id]}"
          end
    else
        redirect_to "/404"
    end
  end

  def create
     @journal = Journal.new(params[:journal])
     flash[:notice]="Criado com sucesso." if @journal.save
     respond_with @journal
  end

  def update
    @journal = Journal.find(params[:id])
      flash[:notice] = "Atualizado com sucesso." if @journal.update_attributes(params[:journal])
      respond_with @journal
  end

  def destroy
    @journal = Journal.find(params[:id])
    @journal.destroy
    redirect_to "/adoptions/#{@journal.adoption.id}/journal"
  end
end