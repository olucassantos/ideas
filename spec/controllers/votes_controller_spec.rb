#encoding:utf-8
require 'spec_helper'
  
  describe VotesController do

      before :each do
        @user = FactoryGirl.create(:user)
        @vote = FactoryGirl.create(:vote)
        @theory = FactoryGirl.create(:theory)
      end

    context 'Creating a new vote when user logged' do

      it 'user should be logged to vote' do
        login_user(@user)
        post :vote, {theory_id: @theory.id, vote: 'true'}
        response.should be_success
      end

      it 'should not vote two times in same choice' do
        login_user(@user)
        post :vote, {theory_id: @theory.id, vote: 'true'}
        post :vote, {theory_id: @theory.id, vote: 'true'}
        @theory.votes.count.should eql(1)
      end

      it 'should redirect to index when has a invalid point' do
        login_user(@user)
        post :vote, {theory_id: @theory.id, vote: 'invalid'}
        response.should be_success
      end
    end

    context 'Creating a new vote when user logged' do

      it 'user should be logged to vote' do
        post :vote, {theory_id: @theory.id, vote: 'true'}
        response.should_not be_success
      end
    end
end

