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
      render json: {status: @vote.save, true: @theory.votes.where(point: true).count , false: @theory.votes.where(point: false).count }
    end

  else
    @vote = Vote.create(point: @point, user_id: current_user.id, theory_id: @theory.id)
  end

 end


 def tipv
  @tip = Tip.find(params[:tip_id])
  @point = "#{params[:vote]}"
  if @point != 'true' && @point != 'false'
    return
  end
  if search_tip
    @vote = search_tip
    if @vote.point == @point
      @vote.destroy
    else
      @vote.point = @point
      render json: {status: @vote.save, true: @tip.votes.where(point: true).count , false: @tip.votes.where(point: false).count }
    end
  else
    @vote = Vote.create(point: @point, user_id: current_user.id, tip_id: @tip.id)
  end
 end

 def search_tip
   Vote.where(tip_id: @tip.id, user_id: current_user.id).first
 end

 def searched_vote
  Vote.where(theory_id: @theory.id, user_id: current_user.id).first
 end
end
