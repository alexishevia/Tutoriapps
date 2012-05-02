# coding: utf-8
# language: es

Cuando /^intente crear un post en el muro de "([^\"]*)"$/ do |nombre|
  group = Group.find_by_name(nombre)
  visit group_path(group)
  @post_attrs = attributes_for(:post)
  within '.new_post' do
    fill_in 'post_text', with: @post_attrs[:text]
    click_button I18n.t('helpers.submit.create', 
        :model => I18n.t('activerecord.models.post'))
  end
end

Entonces /^el post quedará grabado en el sistema$/ do
  @user.posts.find_by_text(@post_attrs[:text]).should_not be_nil
end

Entonces /^el post no quedará grabado en el sistema$/ do
  @user.posts.find_by_text(@post_attrs[:text]).should be_nil
end

Dado /^que "([^\"]*)" tiene (\d+) posts en el muro$/ do |nombre, n|
  group = Group.find_by_name(nombre)
  n.to_i.times do
    post = create(:post, :group => group)
  end
  group.posts.count.should eq(3)
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
