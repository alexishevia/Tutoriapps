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