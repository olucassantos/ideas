require 'spec_helper'
describe IndexController do

  before :each do
    @admin = FactoryGirl.create(:admin)
    @user = FactoryGirl.create(:user)
  end

  describe 'index' do
    context 'when request' do

      it 'should show the lasts theories on user login' do
        login_user(@user)
        response.should be_success
      end

      it 'should show the lasts theories no one logged' do
        response.should be_success
      end

      it 'should show the lasts theories on admin login' do
        login_user(@admin)
        response.should be_success
      end
    end
  end

end
