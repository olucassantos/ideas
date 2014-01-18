require 'spec_helper'

describe Vote do

  it 'should has a user' do
    vote = FactoryGirl.build(:vote, user_id: nil)
    vote.should_not be_valid
   end

  it 'should accept a user' do
    vote = FactoryGirl.build(:vote, user_id: 1)
    vote.should be_valid
   end


   it 'should accept a theory' do
     vote = FactoryGirl.build(:vote, theory_id: 1)
     vote.should be_valid
   end

    it 'should accept a tip' do
     vote = FactoryGirl.build(:vote, tip_id: 1)
     vote.should be_valid
   end
end