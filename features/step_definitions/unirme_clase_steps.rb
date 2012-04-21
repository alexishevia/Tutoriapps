# coding: utf-8
# language: es

Dado /^que se le han dado permisos de administrador$/ do
  @user ||= User.find_by_email(@user_attrs[:email])
  @user.admin = true
  @user.save!
  @user.admin?.should be_true
end

Dado /^que un administrador ha iniciado sesión$/ do
  step 'que un usuario ha sido verificado'
  step 'que se le han dado permisos de administrador'
  step 'intente iniciar sesión'
end

Cuando /^intente crear un grupo nuevo$/ do
  @group_attrs = attributes_for(:group)
  visit new_group_path
  begin
    within "form.new_group" do
      fill_in I18n.t('activerecord.attributes.group.name'), 
        with: @group_attrs[:name]
      click_button I18n.t('helpers.submit.create', 
        :model => I18n.t('activerecord.models.group'))
    end
  rescue Capybara::ElementNotFound
    # forbidden
    raise Capybara::ElementNotFound unless page.status_code == 403
  end
end

Entonces /^el grupo quedará registrado en el sistema$/ do
  Group.find_by_name(@group_attrs[:name]).should_not be_nil
end

Entonces /^el grupo no quedará registrado en el sistema$/ do
  Group.find_by_name(@group_attrs[:name]).should be_nil
end

Dado /^que un estudiante ha iniciado sesión$/ do
  step 'que un usuario ha iniciado sesión'
end

Dado /^que el usuario está matriculado en la materia "([^"]*)"$/ do |nombre|
  group = create(:group, :name => nombre)
  group.members << @user
end

Cuando /^intente acceder al grupo "([^"]*)"$/ do |nombre|
  group = Group.find_by_name(nombre)
  visit group_path(group)
end

Entonces /^podrá ver la información del grupo "([^"]*)"$/ do |nombre|
  group = Group.find_by_name(nombre)
  page.should have_content(group.name)
end

Dado /^el usuario no está matriculado en la clase "([^"]*)"$/ do |nombre|
  group = Group.find_by_name(nombre)
  group.members.exists?(@user).should be_false
end

Dado /^la clase "([^"]*)" ha sido creada$/ do |nombre|
  create(:group, :name => nombre)
end

Entonces /^no podrá ver la información del grupo$/ do
  page.status_code.should eq(403)
end