# encoding: utf-8
class AdoptionsController < ApplicationController
  layout 'empty'
  respond_to :html

  before_filter :logged?, except: [:index, :show]
  before_filter :admin?, except: [:journal]

  def index
    if session[:kind] == 2
      @adoptions = Adoption.all
      respond_with @adoptions
    else
      redirect_to "/404"
    end
  end

  def show
    @adoption = Adoption.find(params[:id]) rescue nil
    if @adoption
      respond_with @adoption
    else
      redirect_to "/404"
    end
  end

  def new
    @adoption = Adoption.new
    respond_with @adoption
  end

  def edit
    @adoption = Adoption.find(params[:id]) rescue nil
    if @adoption
      respond_with @adoption
    else
      redirect_to "/404"
    end
  end

  def create
    @adoption = Adoption.new(params[:adoption])
    flash[:notice]="Adotado com sucesso!" if @adoption.save
    respond_with @adoption
  end

  def update
    @adoption = Adoption.find(params[:id])
    flash[:notice]="Dados atualizados com sucesso!" if @adoption.update_attributes(params[:adoption])
    respond_with @adoption
  end

  def destroy
    @adoption = Adoption.find(params[:id])
    @adoption.destroy
    respond_with @adoption
  end

  def journal
    @adoption = Adoption.find(params[:id])
    @journals = @adoption.journals.page(params[:page]).per(10)
  end
end
