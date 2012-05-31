# coding: utf-8
# language: es

Dado /^está viendo el muro "([^\"]*)"$/ do |wall_name|
  within ".content_panel" do
    click_link wall_name
  end
end

Cuando /^escriba un post$/ do
  @post_attrs = attributes_for(:post)
  within "form.new_post" do
    find('textarea')
    fill_in "text", :with => @post_attrs[:text]
    find('input[type="submit"]')
    click_button I18n.t('helpers.submit.create', :model => 
      I18n.t('activerecord.models.post'))
  end
end

Entonces /^el post aparecerá en el muro "([^\"]*)"$/ do |wall_name|
  within ".content_panel" do
    click_link wall_name
    within ".posts" do
      page.should have_content @post_attrs[:text]
    end
  end
end

Entonces /^el post no aparecerá en el muro "([^\"]*)"$/ do |wall_name|
  within ".content_panel" do
    click_link wall_name
    within ".posts" do
      page.should_not have_content @post_attrs[:text]
    end
  end
end
