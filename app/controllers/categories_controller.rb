#encoding: utf-8
class CategoriesController < ApplicationController
 layout 'empty'
 respond_to 'html'

 before_filter :logged?
 before_filter :admin?, except: [:theories]

  def index
    @categories = Category.all
    respond_with :html
  end

  def show
    @category = Category.find(params[:id]) rescue nil
    if @category
      respond_with @category
    else
      redirect_to "/404"
    end
  end

  def new
    @category = Category.new
    respond_with @category
  end

  def edit
    @category = Category.find(params[:id]) rescue nil
    if @category
      respond_with @category
    else
      redirect_to "/404"
    end
  end

  def create
    @category = Category.new(params[:category])
    flash[:notice]="Cateroria criada com sucesso!" if @category.save
    respond_with @category
  end

  def update
    @category = Category.find(params[:id])
    flash[:notice] = "Atualizada com sucesso !" if @category.update_attributes(params[:category])
    respond_with @category
  end

  def theories
    @category = Category.find(params[:id]) rescue nil
    if @category
      @theories = @category.theories
    else
      redirect_to "/404"
    end
  end

  def tips
    @category = Category.find(params[:id]) rescue nil
    if @category
      @tips = @category.tips
    else
      redirect_to "/404"
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    respond_with @category
  end
end
