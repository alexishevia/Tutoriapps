# coding: utf-8
# language: es

Dado /^que un administrador ha iniciado sesión$/ do
  step 'que un estudiante ha sido verificado'
  step 'que se le han dado permisos de administrador'
  step 'intente iniciar sesión'
end

Cuando /^intente crear un grupo nuevo$/ do
  @group_attrs = attributes_for(:group)
  visit new_group_path
  within "form.new_group" do
    fill_in I18n.t('activerecord.attributes.group.name'), 
      with: @group_attrs[:name]
    click_button I18n.t('helpers.submit.create', 
      :model => I18n.t('activerecord.models.group'))
  end
end

Cuando /^intente crear un grupo nuevo mediante http$/ do
  @group_attrs = attributes_for(:group)
  post groups_path, @group_attrs
end

Entonces /^el grupo quedará registrado en el sistema$/ do
  Group.find_by_name(@group_attrs[:name]).should_not be_nil
end

Entonces /^el grupo no quedará registrado en el sistema$/ do
  Group.find_by_name(@group_attrs[:name]).should be_nil
end

Dado /^que el estudiante "([^\"]*)" ya está registrado$/ do |email|
  user = create(:user, :email => email)
  user.confirmed_at = Time.now
  user.confirmed?.should be_true
end

Dado /^que el estudiante "([^"]*)" no está matriculado en la materia "([^"]*)"$/ do |user_email, group_name|
  user = User.find_by_email(user_email)
  group = Group.find_by_name(group_name)
  group.members.exists?(user).should be_false
end

Cuando /^intente agregar al estudiante "([^"]*)" al grupo "([^"]*)"$/ do |user_email, group_name|
  group = Group.find_by_name(group_name)
  visit group_path(group)
  within '.new_enrollment' do
    fill_in 'enrollment_user_email', :with => user_email
    click_button I18n.t('helpers.submit.add', 
      :model => I18n.t('activerecord.models.user'))
  end
end

Entonces /^el estudiante "([^"]*)" aparecerá dentro del grupo "([^"]*)"$/ do |user_email, group_name|
  user = User.find_by_email(user_email)
  group = Group.find_by_name(group_name)
  visit group_path(group)
  within('.members') do
    page.should have_content(user.name)
  end
end

Dado /^que el estudiante "([^\"]*)" no está registrado$/ do |user_email|
  User.find_by_email(user_email).should be_nil
end

Entonces /^el email "([^"]*)" aparecerá dentro del grupo "([^"]*)"$/ do |user_email, group_name|
  group = Group.find_by_name(group_name)
  visit group_path(group)
  within('.members') do
    page.should have_content(user_email)
  end
end

Dado /^que el correo "([^"]*)" se ha asignado a la clase "([^"]*)"$/ do |user_email, group_name|
  step "que un administrador ha iniciado sesión"
  step "intente agregar al estudiante \"#{user_email}\" al grupo \"#{group_name}\""
  step "cerrar sesión"
end

Dado /^cerrar sesión$/ do
  visit('/users/sign_out')
end

Dado /^que el estudiante "([^\"]*)" no está registrado en el sistema$/ do |user_email|
  User.find_by_email(user_email).should be_nil
end

Cuando /^el estudiante "([^\"]*)" se registre e inicie sesión$/ do |user_email|
  @user_attrs = attributes_for(:user, :email => user_email)
  step "llene y envíe el formulario de registro"
  step "el estudiante haga clic en el link de confirmación"
end

Entonces /^recibirá el status (\d+)$/ do |code|
  last_response.status.should eq(code.to_i)
end