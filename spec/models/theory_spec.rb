# encoding: utf-8
require 'spec_helper'

describe Theory do

  let(:theory) do
    theory = FactoryGirl.create(:theory)
  end

  #Create theory test

  it "should has a theory" do
    theory = FactoryGirl.create(:theory)
  end

  #Teste title

  it "should not have empty title" do
    theory = FactoryGirl.build(:theory, title: '')
    theory.should_not be_valid
  end

  it "should not have a nil title" do
    theory = FactoryGirl.build(:theory, title: nil)
    theory.should_not be_valid
  end

  it "should has maximum 100 characters" do
    theory = FactoryGirl.build(:theory, title:"a"*100)
    theory.should be_valid
  end

  #test justification
    it "have a justification in text" do
      theory = FactoryGirl.build(:theory, justification: "text text"*500)
      theory.should be_valid
    end

    it "should_not be nil justification" do
      theory = FactoryGirl.build(:theory, justification: nil)
      theory.should_not be_valid
    end

    it "should_not be blank justification" do
      theory = FactoryGirl.build(:theory, justification: '')
      theory.should_not be_valid
    end

    #test brief
    it "have a brief in text with 255 chars on maximum" do
      theory = FactoryGirl.build(:theory, brief: "a"*256)
      theory.should_not be_valid
    end

    it "should_not be nil brief" do
      theory = FactoryGirl.build(:theory, brief: nil)
      theory.should_not be_valid
    end

    it "should_not be blank brief" do
      theory = FactoryGirl.build(:theory, brief: '')
      theory.should_not be_valid
    end

    #test description
    it "have a description in text" do
      theory = FactoryGirl.build(:theory, description: "text text"*500)
      theory.should be_valid
    end

    it "should_not be nil description" do
      theory = FactoryGirl.build(:theory, description: nil)
      theory.should_not be_valid
    end

    it "should_not be blank description" do
      theory = FactoryGirl.build(:theory, description: '')
      theory.should_not be_valid
    end
#outlay tests
  it "should not accept letters" do
    theory = FactoryGirl.build(:theory, outlay: "Lucas")
    theory.should_not be_valid
  end

  it "should accept float values" do
    theory = FactoryGirl.build(:theory, outlay: 195.12)
    theory.should be_valid
  end

  it "should not accept ," do
    theory = FactoryGirl.build(:theory, outlay: '195,15')
    theory.should_not be_valid
  end

  context "adoption" do
    it "should have a method to return if was already adopted by an user" do
      theory.should respond_to :adopted_by?
    end

    it "should return empty array if not adopted by user" do
      adoption = FactoryGirl.create(:adoption)
      theory.adopted_by?(Time.now.to_i).size.should == 0
    end

    it "should return filled array if already adopted by user" do
      adoption = FactoryGirl.create(:adoption)
      theory   = adoption.theory
      theory.adopted_by?(theory.user.id).size.should_not == 0
    end
  end
end
