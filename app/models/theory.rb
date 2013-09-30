#encoding: utf-8
class Theory < ActiveRecord::Base
  include ImageSaver
  attr_accessible :brief, :choice, :description, :justification, :outlay, :title, :kind, :user_id, :view, :image_title, :data_stream, :category_ids
        #validates
        validates  :title, length: {maximum: 100}, format:{with: /^[a-zA-ZçÇà-úÀ-Ú ]+$/}
        validates_presence_of :outlay, :brief, :description, :justification, :title
        validates_numericality_of :outlay
        validates_length_of :brief, minimum: 50, maximum: 255
        validates_length_of :description, :justification, minimum: 50
        #relations
        belongs_to :user
        has_many :adoptions,  dependent: :destroy
        has_one :image, as: :imageable,  dependent: :destroy
        has_and_belongs_to_many :categories
        has_many :votes,  dependent: :destroy
        has_many :favorites,  dependent: :destroy
        accepts_nested_attributes_for :categories, allow_destroy: true, reject_if: proc{|attrs| attrs['id'].blank?}
  before_filter: category?

  def inc_view
    self.view = self.view ? self.view+1 : 0
  end

  def adopted_by?(user_id)
    adoptions.where(user_id: user_id)
  end

  def self.search(search)
    search_condition = "%" + search + "%"
    find(:all, conditions: ['title LIKE ? OR description LIKE ? OR justification LIKE ? OR brief LIKE ?', search_condition, search_condition, search_condition, search_condition])
  end

end
