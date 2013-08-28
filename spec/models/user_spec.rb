# encoding: utf-8
require 'spec_helper'

describe User do

  let(:user) do
    user = FactoryGirl.create(:user)
  end

  #Create user test

  it "should has a user" do
    user = FactoryGirl.create(:user)
  end

  #Teste Name
 it "should receive especial characters" do
  user = FactoryGirl.build(:user, name: 'Lucás de çâ dòs Çantos')
  user.should be_valid
end

  it "should not have empty name" do
    user = FactoryGirl.build(:user, name: '')
    user.should_not be_valid
  end

  it "should not have a nil name" do
    user = FactoryGirl.build(:user, name: nil)
    user.should_not be_valid
  end

  it "should has maximum 255 characters" do
    user = FactoryGirl.build(:user, name:"a"*256)
    user.should_not be_valid
  end
  # Code teste

  it "should not have spaces in code" do
    user = FactoryGirl.build(:user, code: 'lucas santos')
    user.should_not be_valid
  end

  it "should not receive simbols in code" do
    user = FactoryGirl.build(:user, code: 'asdasdçÇ')
    user.should be_valid
  end

  it "should not have a blank code" do
    user = FactoryGirl.build(:user, code: '')
    user.should_not be_valid
  end

  it "should not have a nil code" do
    user = FactoryGirl.build(:user, code: nil)
    user.should_not be_valid
  end

  it "should have just number and letters" do
    user = FactoryGirl.build(:user, code: "123a*bc")
    user.should_not be_valid
  end

  it "must return the correct encrypted code" do
    user = FactoryGirl.build(:user, code: Digest::SHA1.hexdigest('123_123456_456'))
    code = User.encrypt_code('123456')
    user.code.should eq code
  end

  it "must get plain text code" do
    user = FactoryGirl.build(:user)
    user.should respond_to :plain_code=
  end

  it "should save the encrypted code in code" do
    user = FactoryGirl.build(:user, plain_code: '123456')
    user.code.should eq User.encrypt_code('123456')
  end

  #email test
  it "should not have empty email" do
    user = FactoryGirl.build(:user, email: '')
    user.should_not be_valid
  end

  it "should not have a nil email" do
    user = FactoryGirl.build(:user, email: nil)
    user.should_not be_valid
  end

  it "should has maximum 255 characters" do
    user = FactoryGirl.build(:user, email:"a"*256)
    user.should_not be_valid
  end

  it "should be a valid email" do
    user = FactoryGirl.build(:user, email: "o.lucas.santos@live.com")
    user.should be_valid
    user = FactoryGirl.build(:user, email: "o.lucas.santosive.com")
    user.should_not be_valid
  end

  #phone test
  it "maybe have empty phone" do
    user = FactoryGirl.build(:user, phone: '')
    user.should be_valid
    user = FactoryGirl.build(:user, phone: '1836064460')
    user.should be_valid
  end

  it "maybe have a nil phone" do
    user = FactoryGirl.build(:user, phone: nil)
    user.should be_valid
  end

  it "should has maximum 12 characters" do
    user = FactoryGirl.build(:user, phone:"a"*13)
    user.should_not be_valid
  end

end