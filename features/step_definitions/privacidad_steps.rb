# coding: utf-8
# language: es

Cuando /^llene y envíe el formulario de registro$/ do
  visit root_path
  within "form.new_user" do
    fill_in I18n.t('activerecord.attributes.user.name'), 
      with: @user_attributes[:name]
    fill_in I18n.t('activerecord.attributes.user.email'), 
      with: @user_attributes[:email]
    fill_in I18n.t('activerecord.attributes.user.password'), 
      with: @user_attributes[:password]
    fill_in I18n.t('activerecord.attributes.user.password_confirmation'),
      with: @user_attributes[:password]
    click_button I18n.t('devise.sign_up')
  end
end

Cuando /^un usuario intente registrarse usando un correo de la UTP$/ do
  @user_attributes = attributes_for(:user).merge(:email => 'fulano@utp.ac.pa')
  Cuando "llene y envíe el formulario de registro"
end

Entonces /^se le enviará un link de confirmación a su correo$/ do
  unread_emails_for(@user_attributes[:email]).size.should == 1
  open_last_email_for(@user_attributes[:email])
  current_email.should have_subject(
    I18n.t('devise.mailer.confirmation_instructions.subject'))
end

Entonces /^quedará registrado en el sistema$/ do
  @user = User.find_by_email(@user_attributes[:email])
  @user.should_not be_nil
end

Entonces /^no aparecerá como verificado$/ do
  @user.confirmed?.should be_false
end

Cuando /^un usuario intente registrarse usando un correo que no es de la UTP$/ do
  @user_attributes = attributes_for(:user).merge(:email => 'fulano@gmail.com')
  Cuando "llene y envíe el formulario de registro"
end

Entonces /^recibirá un mensaje de error$/ do
  page.should have_content I18n.t('activerecord.errors.user.email.only_utp')
end
