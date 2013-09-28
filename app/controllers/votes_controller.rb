#encoding: utf-8
class VotesController < ApplicationController
 
 before_filter :logged?

 def vote
  @theory = Theory.find(params[:theory_id])
  @point = "#{params[:vote]}"

  if @point != 'true' && @point != 'false'
    return
  end

  if searched_vote 
    @vote = searched_vote
    
    if @vote.point == @point
      @vote.destroy
    else
      @vote.point = @point
      render json: {status: @vote.save}
    end

  else
    @vote = Vote.create(point: @point, user_id: current_user.id, theory_id: @theory.id)
  end

 end


 def searched_vote
  Vote.where(theory_id: @theory.id, user_id: current_user.id).first
 end
end
