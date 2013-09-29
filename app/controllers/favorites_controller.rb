#encoding: utf-8
class FavoritesController < ApplicationController

 before_filter :logged?

 def check
  @theory = Theory.find(params[:theory_id])
  @favorite = searched_favorite
    if @favorite
      @favorite.destroy
      render json: {status: @favorite.save, count: @theory.favorites.count}
    else
      @favorite = Favorite.create(check: true, user_id: current_user.id, theory_id: @theory.id)
      render json: {status: @favorite.save, count: @theory.favorites.count}
    end
 end

   def tipf
    @tip = Tip.find(params[:tip_id])
    @favorite = tip_favorite
      if @favorite
        @favorite.destroy
        render json: {status: @favorite.save, count: @tip.favorites.count}
      else
        @favorite = Favorite.create(check: true, user_id: current_user.id, tip_id: @tip.id)
        render json: {status: @favorite.save, count: @tip.favorites.count}
      end
   end

private
 def tip_favorite
  Favorite.where(tip_id: @tip.id, user_id: current_user.id).first
 end

 def searched_favorite
  Favorite.where(theory_id: @theory.id, user_id: current_user.id).first
 end

end