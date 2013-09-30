#encoding:utf-8
require 'spec_helper'
describe TheoriesController do

  before :each do
    @admin = FactoryGirl.create(:admin)
    @user = FactoryGirl.create(:user)
    @theory = FactoryGirl.create(:theory)
    FactoryGirl.create(:category)
  end

  describe 'adopt' do
    context 'when a user adopt a theorie' do
      it 'should redirect to adopted' do
        login_user(@user)
        get :adopt, id: @theory
        response.should redirect_to "/theories/adopted"
      end

      it 'should redirect to 404' do
        login_user(@user)
        get :adopt, id: 98
        response.should_not be_success
      end
    end

    context 'when are admin' do
      it 'should redirect to index' do
        login_admin(@admin)
        get :adopt, id:@user
        response.should redirect_to '/'
      end
    end

    context 'when user not confirm email' do
      it 'should redirect to profile' do
        login_user_invalid(@user)
        get :adopt, id:@user
        response.should redirect_to user_path(@user)
      end
    end

    context 'when idea already adopted' do
      it 'should redirect to profile' do
        login_user(@user)
        get :adopt, id:@theory
        get :adopt, id:@theory
        response.should redirect_to user_path(@user)
      end
    end
  end

  describe 'abandon' do
    context 'when not logged' do
      it 'should redirect to login' do
        get :abandon, id:@user
        response.should redirect_to '/entrar'
      end
    end

    context 'when is logged as admin' do
      it 'should redirect to index' do
        login_admin(@admin)
        get :abandon, id:@user
        response.should redirect_to '/'
      end
    end

    context 'when is a non confirmed user' do
      it 'should redirect to profile' do
        login_user_invalid(@user)
        get :abandon, id:@user
        response.should redirect_to user_path(@user)
      end
    end

    context 'when has no idea adopted' do
      it 'should redirect to profile' do
        login_user(@user)
        get :abandon, id:@theory
        response.should redirect_to user_path(@user)
      end
    end

    context 'when abandon is success' do
      it 'should redirect to theories index' do
        login_user(@user)
        @adoption = FactoryGirl.create(:adoption)
        @adoption.user = @user
        @adoption.save
        get :abandon, id: @adoption.theory.id
        response.should redirect_to theories_path
      end
    end
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
        get :show, id: @theory
        response.should be_success
      end
    end

    context 'when not have theory' do
      it 'should redirect to' do
        login_user(@user)
        get :show, id: 98
        response.should_not be_success
      end
    end
  end

  describe 'new' do

    context 'when not logged' do
      it 'should redirect to login' do
        get :new, id:@theory
        response.should redirect_to '/entrar'
      end
    end

    context 'when is logged admin' do
      it 'should redirect allow create' do
        login_admin(@admin)
        get :new, id:@theory
        response.should be_success
      end
    end

    context 'when is a non confirmed user' do
      it 'should redirect to profile' do
        login_user_invalid(@user)
        get :new, id:@theory
        response.should redirect_to user_path(@user)
      end
    end

    context 'when is valid an create a idea' do
      it 'should create a theory' do
        login_user(@user)
        @ntheory = Theory.new(@theory.attributes.except('id','created_at', 'updated_at'))
        @ntheory.title = 'teste de idea'
        @ntheory.description = 'Descição para a ideia, pode ter caracteres infinitos'
        @ntheory.justification = 'Justificativa para a ideia, usada para atrair os usuarios para seus primordios de doação e adoção.'
        @ntheory.brief = "Resumo, o texto que explica rapidamente o que significa a ideia."
        @ntheory.outlay = 62500
        @ntheory.choice = true
        @ntheory.kind = true
        @ntheory.user_id = 1
        @ntheory.view = 150
        should_not eq('Theory.count') do
          post :create, theory: {title: @theory.title, description: @theory.description, justification: @theory.justification, brief: @theory.brief, outlay: @theory.outlay, choice: @theory.choice,kind: @theory.kind, user_id: @theory.user_id, view: @theory.view}
        end
        response.should be_success
      end
    end
  end


end
