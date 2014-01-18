#encoding: utf-8
require 'spec_helper'

describe 'Login' do

  describe 'user account' do
    before :each do
      @user = FactoryGirl.create(:user)
      @admin = FactoryGirl.create(:admin)
    end

    it 'should login' do
      visit '/entrar'
      fill_in 'email', with: @user.email
      fill_in 'code', with: @user.code
      click_button 'Entrar'
    end

    it 'should not login with email and code blank' do
      visit '/entrar'
      fill_in 'email', with: ''
      fill_in 'code', with: ''
      click_button 'Entrar'
      expect(page).to have_text("Informe email e senha")
    end

    it 'should not login with blank email' do
      visit '/entrar'
      fill_in 'email', with: @user.email
      fill_in 'code', with: ''
      click_button 'Entrar'
      expect(page).to have_text("Informe a senha")
    end

    it 'should not login with blank code' do
        visit '/entrar'
        fill_in 'email', with: ''
        fill_in 'code', with: @user.code
        click_button 'Entrar'
        expect(page).to have_text("Informe o email")
    end

    it 'should not login if is invalid user' do
      visit '/entrar'
      fill_in 'email' , with: 'o.lucasug@jua.com'
      fill_in 'code', with: 'aiasd'
      click_button 'Entrar'
      expect(page).to have_text("Não foi possivel validar seu login.")
    end

    it 'should login when are right and go to index' do
      visit '/entrar'
      fill_in 'email', with: @user.email
      fill_in 'code', with: '123456'
      click_button 'Entrar'
      current_path.should eql(root_path)
    end

    it 'should login as admin when are right and go to index' do
      visit '/entrar'
      fill_in 'email', with: @admin.email
      fill_in 'code', with: '123456'
      click_button 'Entrar'
      current_path.should eql(root_path)
    end

  end

  describe 'Logout' do

    before :each do
      @user = FactoryGirl.create(:user)
      visit '/entrar'
      fill_in 'email', with: @user.email
      fill_in 'code', with: '123456'
      click_button 'Entrar'
    end


    it 'should redirect to index, in logout' do
      visit '/'
      click_link 'Sair'
      expect(page).to have_link('Login')
    end
  end
end
