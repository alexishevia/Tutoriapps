# coding: utf-8
# language: es

Cuando /^llene y envíe el formulario de registro$/ do
  visit root_path
  within "form.sign_up" do
    fill_in 'user_name', with: @user_attrs[:name]
    fill_in 'user_email', with: @user_attrs[:email]
    fill_in 'user_password', with: @user_attrs[:password]
    fill_in 'user_password_confirmation', with: @user_attrs[:password]
    click_button I18n.t('devise.sign_up')
  end
end

Cuando /^un estudiante intente registrarse usando un correo de la UTP$/ do
  @user_attrs = attributes_for(:user, :email => 'fulano@utp.ac.pa')
  step "llene y envíe el formulario de registro"
end

Entonces /^se le enviará un link de confirmación a su correo$/ do
  unread_emails_for(@user_attrs[:email]).size.should == 1
  open_last_email_for(@user_attrs[:email])
  current_email.should have_subject(
    I18n.t('devise.mailer.confirmation_instructions.subject'))
end

Entonces /^quedará registrado en el sistema$/ do
  @user = User.find_by_email(@user_attrs[:email])
  @user.should_not be_nil
end

Entonces /^no aparecerá como verificado$/ do
  @user.confirmed?.should be_false
end

Cuando /^un estudiante intente registrarse usando un correo que no es de la UTP$/ do
  @user_attrs = attributes_for(:user, :email => 'fulano@gmail.com')
  step "llene y envíe el formulario de registro"
end

Entonces /^el estudiante no quedará registrado en el sistema$/ do
  @user = User.find_by_email(@user_attrs[:email])
  @user.should be_nil
end

Dado /^que un estudiante se registró$/ do
  @user_attrs = attributes_for(:user)
  step "llene y envíe el formulario de registro"
end

Dado /^se le envió un link de confirmación$/ do
  step "se le enviará un link de confirmación a su correo"
end

Cuando /^el estudiante haga clic en el link de confirmación$/ do
  open_last_email_for(@user_attrs[:email])
  click_first_link_in_email
end

Entonces /^aparecerá como verificado$/ do
  @user = User.find_by_email(@user_attrs[:email])
  @user.confirmed?.should be_true
end

Dado /^que un estudiante ha sido verificado$/ do
  @user_attrs = attributes_for(:user)
  @user = User.new(@user_attrs)
  @user.confirmed_at = Time.now
  @user.save!
end

Cuando /^intente iniciar sesión$/ do
  visit destroy_user_session_path
  visit root_path
  within "form.sign_in" do
    fill_in 'user_email', with: @user_attrs[:email]
    fill_in 'user_password', with: @user_attrs[:password]
    click_button I18n.t('devise.sign_in')
  end
end

Entonces /^iniciará sesión sin problemas$/ do
  page.should have_content( I18n.t 'devise.sessions.signed_in')
end

Dado /^aún no ha sido verificado$/ do
  @user = User.find_by_email(@user_attrs[:email])
  @user.confirmed?.should be_false
end

Entonces /^no podrá iniciar sesión$/ do
  page.should have_content( I18n.t 'devise.failure.unconfirmed')
end

Dado /^que un estudiante ha iniciado sesión$/ do
  step 'que un estudiante ha sido verificado'
  step 'intente iniciar sesión'
end