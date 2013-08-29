# encoding: utf-8
require 'spec_helper'

describe Category do

  let(:category) do
    category = FactoryGirl.create(:category)
  end

  it "should not be blank" do
    category = FactoryGirl.build(:category, title: '')
    category.should_not be_valid
  end

  it "should not be nil" do
    category = FactoryGirl.build(:category, title: nil)
    category.should_not be_valid
  end

   it "should not countain caracters" do
    category = FactoryGirl.build(:category, title: 'cate%#$321')
    category.should_not be_valid
  end

  it 'should have 30 chars on max' do
    category = FactoryGirl.build(:category, title: 'a'*31)
    should_not be_valid
  end
end