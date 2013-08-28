class Journal < ActiveRecord::Base
  include ImageSaver
  attr_accessible :adoption_id, :image_title, :data_stream, :description

  validate :adoption_id, allow_nil: false, allow_blank:false
  validate :description, length: {minimum: 50}
  belongs_to :adoption
  has_one :image, dependent: :destroy, as: :imageable

end
