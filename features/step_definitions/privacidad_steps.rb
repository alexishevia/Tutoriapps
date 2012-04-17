# coding: utf-8
# language: es
Dado /^que un usuario nuevo está en la página de inicio$/ do
  visit root_path
end

Cuando /^intenta registrarse usando un correo de la UTP$/ do
  user_attributes = attributes_for(:user)
  within ".new_user" do
    fill_in I18n.t('activerecord.attributes.user.name'), 
      with: user_attributes[:name]
    fill_in I18n.t('activerecord.attributes.user.email'), 
      with: user_attributes[:email]
    fill_in I18n.t('activerecord.attributes.user.password'), 
      with: user_attributes[:password]
    fill_in I18n.t('activerecord.attributes.user.confirm_password'),
      with: user_attributes[:password]
    click_button
  end
end

Entonces /^recibe un link de confirmación en su correo$/ do
  pending # express the regexp above with the code you wish you had
end