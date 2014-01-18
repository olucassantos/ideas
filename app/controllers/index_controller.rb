#encoding: utf-8
class IndexController < ApplicationController
  layout "empty"
  respond_to :html
  def index
    @theories = Theory.order("view DESC LIMIT 5")
    @lasts = Theory.order("created_at DESC LIMIT 5")
    @tips = Tip.order("view DESC LIMIT 5")
  end
end
