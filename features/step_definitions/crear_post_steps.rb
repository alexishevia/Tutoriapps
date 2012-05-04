# coding: utf-8
# language: es

Cuando /^intente crear un post en el muro de "([^\"]*)"$/ do |group_name|
  group = Group.find_by_name(group_name)
  visit group_path(group)
  @post_attrs = attributes_for(:post)
  within '.new_post' do
    fill_in 'post_text', with: @post_attrs[:text]
    click_button I18n.t('helpers.submit.create', 
        :model => I18n.t('activerecord.models.post'))
  end
end

Cuando /^intente crear un post en el muro de "([^\"]*)" mediante http$/ do |group_name|
  group = Group.find_by_name(group_name)
  @post_attrs = attributes_for(:post)
  post group_posts_path(group), {:post => @post_attrs}
end

Entonces /^el post quedará grabado en el sistema$/ do
  @user.posts.find_by_text(@post_attrs[:text]).should_not be_nil
end

Entonces /^el post no quedará grabado en el sistema$/ do
  @user.posts.find_by_text(@post_attrs[:text]).should be_nil
end

Dado /^que "([^\"]*)" tiene (\d+) posts en el muro$/ do |nombre, n|
  group = Group.find_by_name(nombre)
  n.to_i.times { create(:post, :group => group) }
end

Cuando /^el estudiante acceda al muro de "([^\"]*)"$/ do |nombre|
  group = Group.find_by_name(nombre)
  visit group_path(group)
end

Entonces /^podrá ver todos los posts que se han creado en el muro de "([^\"]*)"$/ do |nombre|
  group = Group.find_by_name(nombre)
  for post in group.posts
    page.should have_content(post.text)
  end
end

Cuando /^acceda a la página de inicio$/ do
  visit root_path
end

Dado /^que las clases \[([^\]]*)\] han sido creadas$/ do |group_names|
  for group_name in group_names.split(', ') do
    step "que la clase \"#{group_name}\" ha sido creada"
  end
end

Dado /^que los estudiantes \[([^\]]*)\] aparecen como registrados en el sistema$/ do |emails|
  @users_attrs = {}
  for email in emails.split(', ')
    user_attrs = attributes_for(:user, :email => email)
    @users_attrs[email] = user_attrs
    user = User.create!(user_attrs)
    user.confirmed_at = Time.now
    user.save
  end
end

Dado /^que se han creado las siguientes matrículas:$/ do |table|
  for hash in table.hashes do
    for email in hash[:estudiantes].split(', ') do
      step "que el correo \"#{email}\" se ha asignado a la clase \"#{hash[:materia]}\""
    end
  end 
end

Dado /^que "([^\"]*)" escribió un post público$/ do |user_email|
  @user_attrs = @users_attrs[user_email]
  step 'intente iniciar sesión'
  visit root_path
  post_attrs = attributes_for(:post)
  within '.new_post' do
    fill_in 'post_text', with: post_attrs[:text]
    click_button I18n.t('helpers.submit.create', 
      :model => I18n.t('activerecord.models.post'))
  end
end

Cuando /^"([^\"]*)" inicie sesión$/ do |user_email|
  visit destroy_user_session_path
  @user_attrs = @users_attrs[user_email]
  step 'intente iniciar sesión'
end

Entonces /^verá el post de "([^\"]*)"$/ do |user_email|
  post = User.find_by_email(user_email).posts.last
  page.should have_content(post.text)
end