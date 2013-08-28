#encoding: utf-8
require "digest/sha1"
class Admin < ActiveRecord::Base
  attr_protected :code
  attr_accessible :age, :email, :name, :phone, :status, :plain_code
  #validates
  validates :name, presence: true, length: { maximum: 255 }, allow_blank: false, format: {with: /^[a-zA-ZçÇà-úÀ-Ú ]+$/}
  validates :email, allow_blank: false, allow_nil: false, uniqueness: true,length: {maximum: 255} , format: {with:/^[a-zA-Z0-9_.-]+@([a-zA-Z0-9_ -]+\.)+[a-zA-Z]{2,4}$/}
  validates :phone, format: {with: /^\(?\d{2}\)?[\s-]?\d{4}-?\d{4}$/}, allow_nil: false, allow_blank: false
  validate  :age, allow_blank: false
  validates :code, presence: true,format: {with: /^[a-zA-Z0-9 ]+$/}, length: {maximum: 15}, length: {minimum: 5}
  #relations
  has_one :image, dependent: :destroy, as: :imageable


  def plain_code=(code)
    return if code.blank?
    raise StandardError.new("Tamanho de senha inválido!") if !(5..15).include?(code.size)
    self.code = self.class.encrypt_code(code)
  end

  def plain_code
    ""
  end

  def self.encrypt_code(code)
    Digest::SHA1.hexdigest("123_#{code}_456")
  end

  def self.auth(email,code)
    where(["email=? and code=?",email,encrypt_code(code)]).first
  end

end
