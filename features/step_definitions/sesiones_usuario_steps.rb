# coding: utf-8
# language: es

Dado /^que el usuario "([^\"]*)" ha sido creado$/ do |user_email|
  @users_attrs ||= {}
  user_attrs = FactoryGirl.attributes_for(:user, :email => user_email)
  @users_attrs[user_email] = user_attrs
  User.create!(user_attrs)
end

Dado /^que los usuarios \[([^\]]*)\] han sido creados$/ do |emails|
  for email in emails.split(', ')
    step "que el usuario \"#{email}\" ha sido creado"
  end
end

Dado /^que el usuario "([^\"]*)" ha sido confirmado$/ do |user_email|
  user = User.find_by_email(user_email)
  user.confirmed_at = Time.now
  user.save!
end

Dado /^que los usuarios \[([^\]]*)\] han sido confirmados$/ do |emails|
  for email in emails.split(', ')
    step "que el usuario \"#{email}\" ha sido confirmado"
  end
end

Dado /^que el usuario "([^\"]*)" ha sido concedido permisos de administrador$/ do |user_email|
  user = User.find_by_email(user_email)
  user.admin = true
  user.save!
end

Dado /^que los usuarios \[([^\]]*)\] han sido concedidos pedidos de administrador$/ do |emails|
  for email in emails.split(', ')
    step "que el usuario \"#{email}\" ha sido concedido permisos de administrador"
  end
end

Dado /^que el usuario "([^\"]*)" ha sido creado y confirmado$/ do |user_email|
  step "que el usuario \"#{user_email}\" ha sido creado"
  step "que el usuario \"#{user_email}\" ha sido confirmado"
end

Dado /^que los usuarios \[([^\]]*)\] han sido creados y confirmados$/ do |emails|
  for email in emails.split(', ')
    step "que el usuario \"#{email}\" ha sido creado y confirmado"
  end
end

Dado /^que el usuario "([^\"]*)" ha sido creado, confirmado y concedido permisos de administrador$/ do |user_email|
  step "que el usuario \"#{user_email}\" ha sido creado"
  step "que el usuario \"#{user_email}\" ha sido confirmado"
  step "que el usuario \"#{user_email}\" ha sido concedido permisos de administrador"
end

Dado /^que el usuario "([^\"]*)" ha iniciado sesión$/ do |user_email|
  user_attrs = @users_attrs[user_email]
  visit root_path
  within "form.sign_in" do
    fill_in 'user_email', with: user_attrs[:email]
    fill_in 'user_password', with: user_attrs[:password]
    click_button I18n.t('devise.sign_in')
  end
  page.should have_content( I18n.t 'devise.sessions.signed_in')
end

Dado /^cerrar sesión$/ do
  visit('/users/sign_out')
end