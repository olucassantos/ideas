# encoding: utf-8
require 'spec_helper'

describe Admin do

  let(:admin) do
    admin = FactoryGirl.create(:admin)
  end

  #Create admin test

  it "should has a admin" do
    admin = FactoryGirl.create(:admin)
  end

  #Teste Name

  it "should not have empty name" do
    admin = FactoryGirl.build(:admin, name: '')
    admin.should_not be_valid
  end

  it "should not have a nil name" do
    admin = FactoryGirl.build(:admin, name: nil)
    admin.should_not be_valid
  end

  it "should has maximum 255 characters" do
    admin = FactoryGirl.build(:admin, name:"a"*256)
    admin.should_not be_valid
  end
  # Code teste

  it "should not have a blank code" do
    admin = FactoryGirl.build(:admin, code: '')
    admin.should_not be_valid
  end

  it "should not have a nil code" do
    admin = FactoryGirl.build(:admin, code: nil)
    admin.should_not be_valid
  end

  it "should have just number and letters" do
    admin = FactoryGirl.build(:admin, code: "123a*bc")
    admin.should_not be_valid
  end


  it "must get plain text code" do
    admin = FactoryGirl.build(:admin)
    admin.should respond_to :plain_code=
  end

  #email test
  it "should not have empty email" do
    admin = FactoryGirl.build(:admin, email: '')
    admin.should_not be_valid
  end

  it "should not have a nil email" do
    admin = FactoryGirl.build(:admin, email: nil)
    admin.should_not be_valid
  end

  it "should has maximum 255 characters" do
    admin = FactoryGirl.build(:admin, email:"a"*256)
    admin.should_not be_valid
  end

  it "should be a valid email" do
    admin = FactoryGirl.build(:admin, email: "o.lucas.santos@live.com")
    admin.should be_valid
    admin = FactoryGirl.build(:admin, email: "o.lucas.santosive.com")
    admin.should_not be_valid
  end

  #phone test
  it "should not have empty phone" do
    admin = FactoryGirl.build(:admin, phone: '')
    admin.should_not be_valid
    admin = FactoryGirl.build(:admin, phone: '1836064460')
    admin.should be_valid
  end

  it "should not have a nil phone" do
    admin = FactoryGirl.build(:admin, phone: nil)
    admin.should_not be_valid
  end

  it "should has maximum 12 characters" do
    admin = FactoryGirl.build(:admin, phone:"a"*13)
    admin.should_not be_valid
  end

end