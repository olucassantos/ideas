#encoding: utf-8
require 'spec_helper'
describe TipsController do

  before :each do
    @admin = FactoryGirl.create(:admin)
    @user = FactoryGirl.create(:user)
    @tip = FactoryGirl.create(:tip)
  end

  describe 'index' do

    context 'when not logged' do
      it 'should redirect to login' do
        get :index
        response.should redirect_to "/entrar"
      end
    end

    context 'when logged' do
      it 'should redirect to index the theories' do
        login_user(@user)
        get :index
        response.should be_success
      end
    end
  end

  describe 'show' do
    context 'when is logged' do
      it 'should render show' do
        login_user(@user)
        get :show, id: @tip
        response.should be_success
      end
    end

    context 'when not have tip' do
      it 'should redirect to' do
        login_user(@user)
        get :show, id: 5000
        response.should_not be_success
      end
    end
  end

  describe 'new' do

    context 'when not logged' do
      it 'should redirect to login' do
        get :new, id:@tip
        response.should redirect_to '/entrar'
      end
    end

    context 'when is logged admin' do
      it 'should redirect allow create' do
        login_admin(@admin)
        get :new, id: @tip
        response.should be_success
      end

      it 'should redirect allow create' do
        get :new, id: @tip
        response.should redirect_to '/entrar'
      end
    end

    context 'when is a non confirmed user' do
      it 'should redirect to profile' do
        login_user_invalid(@user)
        get :new, id: @tip
        response.should redirect_to user_path(@user)
      end
    end
  end
end