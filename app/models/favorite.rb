class Favorite < ActiveRecord::Base
  attr_accessible :check, :user_id, :theory_id, :tip_id

  validates_presence_of :check, :user

   belongs_to :user
   belongs_to :tip
   belongs_to :theory
end