class Category < ActiveRecord::Base
  attr_accessible :title, :theory_id
  has_and_belongs_to_many :theories

  default_scope order ("title")

  validates :title, presence: true, length: {maximum:30}, format: {with: /^[a-zA-Z ]+$/}
  accepts_nested_attributes_for :theories, allow_destroy: true
end
