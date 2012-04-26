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
  within '.add_user' do
    fill 'user_email', :with => user_email
    click_button I18n.t('helpers.submit.add', 
      :model => I18n.t('activerecord.models.user'))
  end
end