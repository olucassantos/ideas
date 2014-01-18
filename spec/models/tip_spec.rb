# encoding: utf-8
require 'spec_helper'

describe Tip do

  let(:tip) do
    tip = FactoryGirl.create(:tip)
  end

  #Create tip test

  it "should has a tip" do
    tip = FactoryGirl.create(:tip)
  end

  #Teste title

  it "should not have empty title" do
    tip = FactoryGirl.build(:tip, title: '')
    tip.should_not be_valid
  end

  it "should not have a nil title" do
    tip = FactoryGirl.build(:tip, title: nil)
    tip.should_not be_valid
  end

  it "should has maximum 100 characters" do
    tip = FactoryGirl.build(:tip, title:"a"*100)
    tip.should be_valid
  end

    #test brief
    it "have a brief in text with 255 chars on maximum" do
      tip = FactoryGirl.build(:tip, brief: "a"*256)
      tip.should_not be_valid
    end

    it "should_not be nil brief" do
      tip = FactoryGirl.build(:tip, brief: nil)
      tip.should_not be_valid
    end

    it "should_not be blank brief" do
      tip = FactoryGirl.build(:tip, brief: '')
      tip.should_not be_valid
    end

    #test description
    it "have a description in text" do
      tip = FactoryGirl.build(:tip, description: "text text"*500)
      tip.should be_valid
    end

    it "should_not be nil description" do
      tip = FactoryGirl.build(:tip, description: nil)
      tip.should_not be_valid
    end

    it "should_not be blank description" do
      tip = FactoryGirl.build(:tip, description: '')
      tip.should_not be_valid
    end

    #test tags
    it "have a tags in text wit maximun 255chars" do
      tip = FactoryGirl.build(:tip, tags: "text text"*500)
      tip.should_not be_valid
      tip = FactoryGirl.build(:tip, tags: "a"*255)
      tip.should be_valid
    end

    it "should_not be nil tag" do
      tip = FactoryGirl.build(:tip, tags: nil)
      tip.should_not be_valid
    end

    it "should_not be blank tag" do
      tip = FactoryGirl.build(:tip, tags: '')
      tip.should_not be_valid
    end
end