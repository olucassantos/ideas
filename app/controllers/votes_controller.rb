# encoding: utf-8
class VotesController < ApplicationController
  before_filter :logged?
  respond_to :html
end
