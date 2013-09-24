#encoding: utf-8
class Theory < ActiveRecord::Base
  include ImageSaver
  attr_accessible :brief, :choice, :description, :justification, :outlay, :title, :kind, :user_id, :view, :image_title, :data_stream, :category_ids
        #validates
        validates  :title, presence: true, length: {maximum: 100}, format:{with: /^[A-Za-z ]+$/}
        validates  :outlay, presence: true
        validate    :choice, presence: true
        validate    :kind, presence: true
        validates  :brief, presence:true
        validates   :description, presence:true
        validates   :justification, presence:true
        validates_numericality_of :outlay
        validates_length_of :brief, minimum: 50, maximum: 255
        validates_length_of :description, minimum: 50
        validates_length_of :justification, minimum: 50
        #relations
        belongs_to :user
        has_many :adoptions,  dependent: :destroy
        has_one :image, as: :imageable,  dependent: :destroy
        has_and_belongs_to_many :categories
        has_many :votes

  def inc_view
    self.view = self.view ? self.view+1 : 0
  end

  def adopted_by?(user_id)
    adoptions.where(user_id: user_id)
  end

  def self.search(search)
    search_condition = "%" + search + "%"
    find(:all, conditions: ['title LIKE ?', search_condition])
  end

end
