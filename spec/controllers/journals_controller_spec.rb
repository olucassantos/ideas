#encoding:utf-8
require 'spec_helper'
describe JournalsController do

  before :each do
    @admin = FactoryGirl.create(:admin)
    @user = FactoryGirl.create(:user)
    @journal = FactoryGirl.create(:journal)
    @adoption = @journal.adoption
  end

  describe "When not logged" do

    context 'GET index' do
      it 'should redirect to entrar' do
        get :index
        response.should redirect_to "/entrar"
      end
    end

    context 'GET show' do
      it 'should redirect to entrar' do
        get :show,id: @journal
        response.should redirect_to "/entrar"
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
        get :edit,id: @journal
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
        get :update,id: @journal
        response.should redirect_to "/entrar"
      end
    end

    context 'GET destroy' do
      it 'should redirect to entrar' do
        get :destroy,id: @journal
        response.should redirect_to "/entrar"
      end
    end
  end

  describe 'When logged as user' do

    context 'GET index' do
      it 'should redirect to 404' do
        login_user(@user)
        get :index
        response.should redirect_to "/404"
      end
    end

    context 'GET show' do
      it 'should redirect to show of journal' do
        login_user(@user)
        get :show,id: @journal
        response.should be_success
      end
    end

    context 'GET new' do
      it 'should redirect to create' do
        login_user(@user)
        get :new
        assigns(:journal).should
      end
    end

    context 'GET edit' do
      it 'should redirect to be success' do
        login_user(@user)
        get :edit,id: @journal
        response.should be_success
      end
    end

    context 'GET create' do
      it 'should redirect to entrar' do
        login_user(@user)
        @njournal = Journal.new(@journal.attributes.except('id', 'created_at', 'updated_at'))
        @njournal.description = "Teste de descrição do diario"
        should_not eq ('Journal.count') do
          post :create, journal: {description: @njournal.description}
        end
        response.should be_success
      end
    end

    context 'GET update' do
      it 'should redirect to form journal after updated' do
        login_user(@user)
        get :update,id: @journal
        response.should redirect_to journal_path
      end
    end

    context 'GET destroy' do
      it 'should destroy journal' do
        login_user(@user)
        expect{delete :destroy, id: @journal}.to change(Journal,:count).by(-1)
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
        get :show,id: @journal
        response.should be_success
      end
    end

    context 'GET new' do
      it 'should redirect not enter' do
        login_admin(@admin)
        get :new
        response.should_not be_success
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
      it 'should cerate a journal' do
        login_admin(@admin)
        @njournal = Journal.new(@journal.attributes.except('id','created_at', 'updated_at'))
        @njournal.description = "Sou o poder do mundo, como admin master"
        should_not eq('Journal.count') do
          post :create, journal: {description: @njournal.description}
        end
        response.should be_success
      end
    end

    context 'GET update' do
      it 'should update journal' do
        login_admin(@admin)
        put :update, id: @journal, journal: {description: @journal.description}
        response.should redirect_to journal_path
      end
    end

    context 'GET destroy' do
      it 'should destroy journals' do
        login_admin(@admin)
        expect{delete :destroy, id: @journal }.to change(Journal,:count).by(-1)
      end
    end
  end
end
