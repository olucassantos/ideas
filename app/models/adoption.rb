class Adoption < ActiveRecord::Base
  attr_accessible :rating, :theory_id, :user_id

  validate :theory_id, presence: true
  validate :user_id, presence: true
  validate :rating

  belongs_to :theory
  belongs_to :user
  has_many  :journals, dependent: :destroy
end
