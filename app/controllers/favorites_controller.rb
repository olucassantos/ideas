#encoding: utf-8
class FavoritesController < ApplicationController
 
 before_filter :logged?

 def check
  @theory = Theory.find(params[:theory_id])
  @favorite = searched_favorite
    if @favorite
      @favorite.destroy
    else
      @favorite = Favorite.create(check: true, user_id: current_user.id, theory_id: @theory.id)
      render json: {status: @favorite.save}
    end
 end

 def ownerFavorite

 end


private
 def searched_favorite
  Favorite.where(theory_id: @theory.id, user_id: current_user.id).first
 end

end