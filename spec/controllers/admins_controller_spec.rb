#encoding:utf-8
require 'spec_helper'
describe AdminsController do

  before :each do
    @admin = FactoryGirl.create(:admin)
    @user = FactoryGirl.create(:user)
    @theory = FactoryGirl.create(:theory)
  end


  describe 'when logged who admin' do

    context 'GET INDEX' do
      it 'shold get index' do
        login_admin(@admin)
        get :index
        response.should be_success
      end
    end

    context 'GET SHOW' do
      it 'shold return a admin' do
        login_admin(@admin)
        get :show, id: @admin
        response.should be_success
      end

      it 'if has no user, should raise an error' do
        login_admin(@admin)
        get :show, id: 90
        response.should_not be_success
      end
    end

    context 'GET NEW' do
      it 'should assign a new admin obeject' do
        login_admin(@admin)
        get :new
        response.should be_success
      end
    end

    context 'GET EDIT' do
      it 'should assign edit a admin' do
        login_admin(@admin)
        get :edit, id: @admin
        response.should be_success
      end
    end

    context 'GET CREATE' do
      it 'should create a user' do
        login_admin(@admin)
        @nadmin = Admin.new(@admin.attributes.except('id', 'created_at','code','updated_at','admin'))
        @nadmin.name = "Poderoso chefão"
        @nadmin.email = "o.lcuas.sasanto@live.com"
        @nadmin.age = "1995-08-05"
        @nadmin.phone = "1836064460"
        should_not eq('Admin.count') do
          post :create, admin: {name: @admin.name, email: @admin.email,age: @admin.age, phone: @admin.phone}
        end
        response.should be_success
      end
    end
  end

  describe 'when not logged who admin' do
    context 'GET CREATE' do
      it 'should not create' do
        get :create
        response.should redirect_to "/entrar"
      end
    end

    context 'GET INDEX' do
      it 'should return index' do
        get :index
        response.should redirect_to "/entrar"
      end
    end

    context 'GET SHOW' do
      it 'should not show admin' do
        get :show, id: @admin
        response.should redirect_to "/entrar"
      end
    end

    context 'GET NEW' do
      it 'should assign a new obeject' do
        get :new
        response.should redirect_to "/entrar"
      end
    end

    context 'GET EDIT' do
      it 'should not edit a admin' do
        get :edit,id: @admin
        response.should redirect_to "/entrar"
      end
    end

    context 'GET UPDATE' do
      it 'should not update admin data' do
        get :update,id: @admin
        response.should redirect_to "/entrar"
      end
    end

    context 'GET DESTROY' do
      it 'should not destroy a admin' do
        get :destroy,id: @admin
        response.should redirect_to "/entrar"
      end
    end
  end
end
