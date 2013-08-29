require 'spec_helper'
describe UsersController do

  before :each do
    @admin = FactoryGirl.create(:admin)
    @user = FactoryGirl.create(:user)
  end

  describe "GET index" do

    context "when not logged" do
      it 'should redirect to login' do
        get :index
        response.should redirect_to "/entrar"
      end
    end

    context "when not admin" do
      it "should redirect to login" do
        get :index
        response.should redirect_to "/entrar"
      end
    end
 end

  describe "GET new" do
    it "assigns a new object to user" do
      get :new
      assigns(:user).should
    end

    context "are logged" do
      it "should redirect to index" do
        login_user(@user)
        get :new
        response.should redirect_to "/"
      end
    end
  end

  describe "GET edit" do

    context "are logged" do
      it 'should response with a user' do
        login_user(@user)
        get :edit, id: @user
        response.should be_success
      end
    end

    context "are not logged" do
      it 'should redirect to 404' do
        get :edit, id: @user.id
        response.should_not be_success
      end
    end

    it 'should update user' do
      @user
      controller.should_receive(:logged?)
      put :update, id: @user, user: { age: @user.age, email: @user.email, name: @user.name, code: @user.code, about: @user.about}
      response.should be_success
    end
  end

  describe "GET create" do
    it  'should create user' do
      @new_user = User.new(@user.attributes.except('id', 'code','admin' ,'created_at', 'updated_at'))
      @new_user.email = "test@gmail.com"
      @new_user.name = "Lucas"
      should_not eq('User.count') do
        post :create, user: {age: @new_user.age, email: @new_user.email, name: @new_user.name, code: @new_user.code, about: @new_user.about}
      end
      response.should be_success
    end

    it 'render the new view' do
      get :new, id:@user
      response.should render_template :new
    end
  end

  describe 'show' do

    it 'should show user' do
      login_user @user
      get :show, id: @user.id
      response.should be_success
    end

    it 'renders the show view' do
      login_user @user
      get :show, id: @user
      response.should render_template :show
    end
  end
end