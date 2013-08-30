require 'spec_helper'
describe CategoriesController do

  before :each do
    @admin = FactoryGirl.create(:admin)
    @user = FactoryGirl.create(:user)
    @category = FactoryGirl.create(:category)
  end

  describe "When not logged" do
    context 'GET index' do
      it 'should redirect to index' do
        get :index
        response.should redirect_to "/"
      end
    end

    context 'GET show' do
      it 'should redirect to index' do
        get :show,id: @category
        response.should redirect_to "/"
      end
    end

    context 'GET new' do
      it 'should redirect to index' do
        get :new
        response.should redirect_to "/"
      end
    end

    context 'GET edit' do
      it 'should redirect to index' do
        get :edit,id: @category
        response.should redirect_to "/"
      end
    end

    context 'GET create' do
      it 'should redirect to index' do
        get :create
        response.should redirect_to "/"
      end
    end

    context 'GET update' do
      it 'should redirect to index' do
        get :update,id: @category
        response.should redirect_to "/"
      end
    end

    context 'GET destroy' do
      it 'should redirect to index' do
        get :destroy,id: @category
        response.should redirect_to "/"
      end
    end
  end

  describe 'when logged as user' do
        context 'GET index' do
      it 'should redirect to index' do
        login_user(@user)
        get :index
        response.should redirect_to "/"
      end
    end

    context 'GET show' do
      it 'should redirect to index' do
        login_user(@user)
        get :show,id: @category
        response.should redirect_to "/"
      end
    end

    context 'GET new' do
      it 'should redirect to index' do
        login_user(@user)
        get :new
        response.should redirect_to "/"
      end
    end

    context 'GET edit' do
      it 'should redirect to index' do
        login_user(@user)
        get :edit,id: @category
        response.should redirect_to "/"
      end
    end

    context 'GET create' do
      it 'should redirect to index' do
        login_user(@user)
        get :create
        response.should redirect_to "/"
      end
    end

    context 'GET update' do
      it 'should redirect to index' do
        login_user(@user)
        get :update,id: @category
        response.should redirect_to "/"
      end
    end

    context 'GET destroy' do
      it 'should redirect to index' do
        login_user(@user)
        get :destroy,id: @category
        response.should redirect_to "/"
      end
    end
  end

  describe 'when logged as admin' do

     context 'GET index' do
      it 'should redirect to index' do
        login_admin(@admin)
        get :index
        response.should be_success
      end
    end

    context 'GET show' do
      it 'should redirect to categories show' do
        login_admin(@admin)
        get :show,id: @category
        response.should be_success
      end
    end

    context 'GET new' do
      it 'should redirect response a object' do
        login_admin(@admin)
        get :new
        response.should be_success
      end
    end

    context 'GET edit' do
      it 'should redirect to edit' do
        login_admin(@admin)
        get :edit,id: @category
        response.should be_success
      end
    end

    context 'GET create' do
      it 'should cerate a category' do
        login_admin(@admin)
        @ncategory = Category.new(@category.attributes.except('id','created_at', 'updated_at'))
        @ncategory.title = "Teste Factorie"
        should_not eq('Category.count') do
          post :create, category: {title: @ncategory.title}
        end
        response.should be_success
      end
    end

    context 'GET update' do
      it 'should update category to redirect create' do
        login_admin(@admin)
        put :update, id: @category, category: {title: @category.title}
        response.should redirect_to category_path
      end
    end

    context 'GET destroy' do
      it 'should destroy category' do
        login_admin(@admin)
        expect{delete :destroy, id: @category }.to change(Category,:count).by(-1)
      end
    end
  end
end