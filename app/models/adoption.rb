class Adoption < ActiveRecord::Base
  attr_accessible :rating, :theory_id, :user_id

  validate :theory_id, allow_nil: false
  validate :user_id, allow_nil: false
  validate :rating, allow_nil: true

  belongs_to :theory
  belongs_to :user
  has_many  :journals, dependent: :destroy
end
