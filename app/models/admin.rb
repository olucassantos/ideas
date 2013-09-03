#encoding: utf-8

class Admin < User
  attr_protected :code
  attr_accessible :age, :email, :name, :phone, :status, :plain_code
  #validates
  validates :name, presence: true, length: { maximum: 255 }, allow_blank: false, format: {with: /^[a-zA-ZçÇà-úÀ-Ú ]+$/}
  validates :email, presence: true, uniqueness: true,length: {maximum: 255} , format: {with:/^[a-zA-Z0-9_.-]+@([a-zA-Z0-9_ -]+\.)+[a-zA-Z]{2,4}$/}
  validates :phone, format: {with: /^\(?\d{2}\)?[\s-]?\d{4}-?\d{4}$/}, allow_nil: false, allow_blank: false
  validate  :age, presence: true
  validates :code, presence: true,format: {with: /^[a-zA-Z0-9 ]+$/}, length: {maximum: 15}, length: {minimum: 5}
  #relations
  has_one :image, dependent: :destroy, as: :imageable
end
