# coding: utf-8
# language: es
Cuando /^un usuario intente registrarse usando un correo de la UTP$/ do
  user_attributes = attributes_for(:user).merge(:email => 'fulano@utp.ac.pa')
  within "form.new_user" do
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