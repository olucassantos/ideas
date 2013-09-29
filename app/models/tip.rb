#encoding: utf-8
class Tip < ActiveRecord::Base
  include ImageSaver
  attr_accessible :brief, :description, :title, :user_id, :view, :tags, :image_title, :data_stream
  validates_presence_of :brief, :description, :title, :tags
  belongs_to :user
  has_one :image, as: :imageable,  dependent: :destroy
  has_many :votes,  dependent: :destroy
  has_many :favorites,  dependent: :destroy


  validates  :title, length: {maximum: 100}, format:{with: /^[a-zA-ZçÇà-úÀ-Ú ]+$/}
  validates_length_of :brief, minimum: 50, maximum: 255
  validates_length_of :description, minimum: 50
  validates_length_of :tags, maximum: 255

  def inc_view
    self.view = self.view ? self.view+1 : 0
  end

end