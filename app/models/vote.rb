#encoding: utf-8
class Vote < ActiveRecord::Base
  attr_accessible :point, :theory_id, :user_id

  belongs_to :user
  belongs_to :theory

  validates_presence_of :theory_id, :user_id

end
