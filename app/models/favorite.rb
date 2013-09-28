class Favorite < ActiveRecord::Base
	attr_accessible :check, :user_id, :theory_id

	validates_presence_of :check, :user, :theory

	belongs_to :user
	belongs_to :theory
end