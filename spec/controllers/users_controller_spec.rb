require 'spec_helper'
describe UsersController do
let(:valid_attributes) { {}}

  before :each do
    @admin = FactoryGirl.create(:admin)
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
  end

end