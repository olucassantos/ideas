# encoding: utf-8
require "digest/sha1"
class User < ActiveRecord::Base
  include ImageSaver

  attr_protected :code
  attr_accessible :about, :age, :email, :name, :phone, :tested, :plain_code, :theory_id, :token, :image_title, :data_stream, :status
  #validates
  validates :name, presence: true, length: { maximum: 200 }, format: {with: /^[a-zA-ZçÇà-úÀ-Ú ]+$/}
  validates :email, presence: true, uniqueness: true,length: {maximum: 200} , format: {with:/^[a-zA-Z0-9_.-]+@([a-zA-Z0-9_ -]+\.)+[a-zA-Z]{2,4}$/}
  validates :phone, format: {with: /^\(?\d{2}\)?[\s-]?\d{4}-?\d{4}$/}, allow_blank: true, allow_nil: true
  validate  :about
  validate  :age
  validate  :tested
  validates :code, presence: true,format: {with: /^[a-zA-Z0-9çÇ]+$/}, length: {maximum: 15}, length: {minimum: 5}
  #relations
  has_many  :theories , dependent: :destroy
  has_many :adoptions, dependent: :destroy
  has_many :journals, through: :adoptions
  has_one :image, dependent: :destroy, as: :imageable
  has_many :votes
  has_many :favorites

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
