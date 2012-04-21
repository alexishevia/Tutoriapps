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

Cuando /^intenta crear un grupo nuevo$/ do
  @group_attrs = attributes_for(:group)
  visit new_group_path
  within "form.new_group" do
    fill_in I18n.t('activerecord.attributes.group.name'), 
      with: @group_attrs[:name]
    click_button I18n.t('helpers.submit.create', 
      :model => I18n.t('activerecord.models.group'))
  end
end

Entonces /^el grupo queda registrado en el sistema$/ do
  Group.find_by_name(@group_attrs[:name]).should_not be_nil
end