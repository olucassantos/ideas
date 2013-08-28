#encoding: utf-8
class ErrorsController < ApplicationController
  def routing
    redirect_to "/404"
  end
end