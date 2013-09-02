#encoding:utf-8
require 'spec_helper'

describe 'AdoptionsController' do

  before :each do
    @admin = FactoryGirl.create(:admin)
  end

  context 'when is logged as admin' do

    before :each do
      visit '/entrar'
      fill_in 'email', with: @admin.email
      fill_in 'code', with: '123456'
      click_button 'Autenticar'
    end

    it 'should have a link to adoption' do
      visit '/'
      click_link ('Adoções')
      expect(page).to have_text("Adoções")
    end

    it 'should have a link to show adoption' do
      visit '/'
      click_link ('Adoções')
      click_link ('Mostrar')
      expect(page).to have_text("Adoção")
    end



  end
end