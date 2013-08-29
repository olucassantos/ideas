# encoding: utf-8
class VotesController < ApplicationController

  before_filter :logged?
  respond_to :html

   def logged?
    if !session[:id]
      redirect_to "/entrar"
      flash[:notice] = "Você precisa esta cadastrado para votar."
    end
  end

end