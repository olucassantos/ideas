require 'spec_helper'
describe AdoptionsController do

  before :each do
    @admin = FactoryGirl.create(:admin)
    @user = FactoryGirl.create(:user)
    @adoption = FactoryGirl.create(:adoption)
  end

  describe "When not logged" do

    context 'GET index' do
      it 'should redirect to index' do
        get :index
        response.should redirect_to "/"
      end
    end

    context 'GET show' do
      it 'should redirect to entrar' do
        get :show,id: @adoption
        response.should redirect_to "/"
      end
    end

    context 'GET new' do
      it 'should redirect to entrar' do
        get :new
        response.should redirect_to "/entrar"
      end
    end

    context 'GET edit' do
      it 'should redirect to entrar' do
        get :edit,id: @adoption
        response.should redirect_to "/entrar"
      end
    end

    context 'GET create' do
      it 'should redirect to entrar' do
        get :create
        response.should redirect_to "/entrar"
      end
    end

    context 'GET update' do
      it 'should redirect to entrar' do
        get :update,id: @adoption
        response.should redirect_to "/entrar"
      end
    end

    context 'GET destroy' do
      it 'should redirect to entrar' do
        get :destroy,id: @adoption
        response.should redirect_to "/entrar"
      end
    end

    context 'GET journal' do
      it 'should redirect to entrar' do
        get :journal,id: @adoption
        response.should redirect_to "/entrar"
      end
    end
  end

  describe 'When logged as user' do

    context 'GET index' do
      it 'should redirect to index' do
        login_user(@user)
        get :index
        response.should redirect_to "/"
      end
    end

    context 'GET show' do
      it 'should redirect to entrar' do
        login_user(@user)
        get :show,id: @adoption
        response.should redirect_to "/"
      end
    end

    context 'GET new' do
      it 'should redirect to entrar' do
        login_user(@user)
        get :new
        response.should redirect_to "/"
      end
    end

    context 'GET edit' do
      it 'should redirect to entrar' do
        login_user(@user)
        get :edit,id: @adoption
        response.should redirect_to "/"
      end
    end

    context 'GET create' do
      it 'should redirect to entrar' do
        login_user(@user)
        get :create
        response.should redirect_to "/"
      end
    end

    context 'GET update' do
      it 'should redirect to entrar' do
        login_user(@user)
        get :update,id: @adoption
        response.should redirect_to "/"
      end
    end

    context 'GET destroy' do
      it 'should redirect to entrar' do
        login_user(@user)
        get :destroy,id: @adoption
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
      it 'should redirect to adoption show' do
        login_admin(@admin)
        get :show,id: @adoption
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
        get :edit,id: @adoption
        response.should be_success
      end
    end

    context 'GET create' do
      it 'should cerate a adoption' do
        login_admin(@admin)
        @nadoption = Adoption.new(@adoption.attributes.except('id','created_at', 'updated_at'))
        @nadoption.user_id = 2
        @nadoption.theory_id = 2
        should_not eq('Adoption.count') do
          post :create, adoption: {user_id: @nadoption.user_id, theory_id: @nadoption.theory_id}
        end
        response.should be_success
      end
    end

    context 'GET update' do
      it 'should update user to redirect create' do
        login_admin(@admin)
        put :update, id: @adoption, adoption: {user_id: @adoption.user_id, theory_id: @adoption.theory_id}
        response.should redirect_to adoption_path
      end
    end

    context 'GET destroy' do
      it 'should destroy adoptions' do
        login_admin(@admin)
        expect{delete :destroy, id: @adoption }.to change(Adoption,:count).by(-1)
      end
    end
  end
end