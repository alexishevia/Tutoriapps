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
  @user.posts.where('text = ?', @post_attrs[:text]).count.should eq(1)
end