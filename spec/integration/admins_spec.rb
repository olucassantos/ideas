require 'spec_helper'

describe 'AdminsController' do

    before :each do
      @admin = FactoryGirl.create(:admin)
    end

  context 'when  logged as admin' do

    before :each do
      visit '/entrar'
      fill_in 'email', with: @admin.email
      fill_in 'code', with: '123456'
      click_button 'Autenticar'
    end

    it 'should enter page index of admin' do
      visit '/'
      click_link 'Administradores'
      expect(page).to have_text('Lista de Administradores')
    end

    it 'should view a admin profile' do
      visit '/'
      click_link 'Administradores'
      click_link "#{@admin.name}"
      expect(page).to have_text("Name: #{@admin.name}")
    end

    it 'should enter in edit a new admin' do
        visit '/'
        click_link 'Administradores'
        click_link 'Editar'
        expect(page).to have_text("Editar Administrador")
    end

    it 'should create a admin' do
        visit '/'
        click_link 'Administradores'
        click_link 'Cadastrar Novo Administrador'
        expect(page).to have_text("Novo Administrador")
    end
  end

    context 'when logged not logged' do

    it 'should enter page index of admin' do
      visit '/'
      expect(page).to_not have_link('Administradores')
    end
  end
end