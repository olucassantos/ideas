class Category < ActiveRecord::Base
  attr_accessible :title, :theory_id
  has_and_belongs_to_many :theories

  default_scope order ("title")

  validates :title, presence: true, allow_blank: false, allow_nil: false, length: {maximum:30}, format: {with: /^[a-zA-Z ]+$/}

end
