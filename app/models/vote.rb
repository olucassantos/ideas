#encoding: utf-8
class Vote < ActiveRecord::Base
  attr_accessible :point, :theory_id, :user_id, :tip_id

  belongs_to :user
  belongs_to :theory
  belongs_to :tip

  validates_presence_of  :user_id

end
