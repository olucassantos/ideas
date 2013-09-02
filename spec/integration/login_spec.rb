#encoding: utf-8
require 'spec_helper'

describe 'Login' do

  describe 'user account' do
    before :each do
      @user = FactoryGirl.create(:user)
    end

    it 'shold login' do
      visit '/entrar'
      fill_in 'email', with: @user.email
      fill_in 'code', with: @user.code
      click_button 'Autenticar'
    end

    it 'should not login with email and code blank' do
      visit '/entrar'
      fill_in 'email', with: ''
      fill_in 'code', with: ''
      click_button 'Autenticar'
      expect(page).to have_text("Informe email e senha")
    end

    it 'should not login with blank email' do
      visit '/entrar'
      fill_in 'email', with: @user.email
      fill_in 'code', with: ''
      click_button 'Autenticar'
      expect(page).to have_text("Informe a senha")
    end

    it 'should not login with blank code' do
        visit '/entrar'
        fill_in 'email', with: ''
        fill_in 'code', with: @user.code
        click_button 'Autenticar'
        expect(page).to have_text("Informe o email")
    end

    it 'should not login if is invalid user' do
      visit '/entrar'
      fill_in 'email' , with: 'o.lucasug@jua.com'
      fill_in 'code', with: 'aiasd'
      click_button 'Autenticar'
      expect(page).to have_text("Não foi possivel validar seu login")
    end

    it 'should login when are right and go to index' do
      visit '/entrar'
      fill_in 'email', with:'o.lucas.santos@live.com'
      fill_in 'code', with:'123asda'
      click_button 'Autenticar'
      p current_path
      expect(page).to have_text("Logado como:")
    end
  end
end