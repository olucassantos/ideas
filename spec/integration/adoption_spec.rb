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
      click_button 'Entrar'
    end

    it 'should have a link to adoption' do
      visit '/'
      click_link ('Adoções')
      current_path.should eql(adoptions_path)
    end

    it 'should have a link to show adoption' do
      visit '/'
      click_link ('Adoções')
      click_link ('Nova Adoção')
    end



  end
end