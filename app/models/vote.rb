class Vote < ActiveRecord::Base

  attr_accessible :user_id, :vote, :theory_id

  #validates
  validate :user_id, presence: true
  validate :vote, presence: true
  validate :theory_id, presence: true
  #relations
  belongs_to :user
  belongs_to :theory

end