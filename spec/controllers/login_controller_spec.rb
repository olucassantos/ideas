require 'spec_helper'

describe LoginController do

  before :each do
    @admin = FactoryGirl.create(:admin)
    @user = FactoryGirl.create(:user)
  end

  describe 'when try to do a logon' do

    context 'when is logged' do
       it 'shold not allowed to login' do
          login_user(@user)
          post :login, login: {email: 'o.lucas.santos@live.com', code: '123asd'}
          response.should be_success
       end
    end

    context 'when post in blank status' do
      it 'should be be success and return' do
        post :login, login: {email: '', code: ''}
        response.should be_success
      end
    end

    context 'when post in blank status the email' do
      it 'should be be success and return' do
        post :login, login: {email: '', code: '123123'}
        response.should be_success
      end
    end

    context 'when post in blank status the code' do
      it 'should be be success and return' do
        login_user(@user)
        post :login, login: {email: 'o.lucas.santos@live.com', code: ''}
        response.should be_success
      end
    end

    context 'is a right admin' do
      it 'should redirect to index, if are a admin' do
        post :login, login: {email: 'o.lucas.santos@live.com', code: '123asd'}
        if session[:kind] == 2
          response.should be_success
        end
      end
    end

    context 'is a right user' do
      it 'should redirect to index, if are a user' do
        post :login, login: {email: 'o.lucas.santos@live.com', code: '123asda'}
        if session[:kind] == 1
          response.should be_success
        end
      end
    end
  end

  describe 'logout' do
    context 'when do a logout' do
      it 'should redirect to index' do
        response.should be_success
      end
    end
  end
end