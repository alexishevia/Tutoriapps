# coding: utf-8
# language: es

Dado /^que está viendo el muro "([^\"]*)"$/ do |wall_name|
  within "#groups_panel" do
    page.click_link wall_name
  end
end

Cuando /^escriba un post$/ do
  @post_attrs = attributes_for(:post)
  find('form.new_post textarea').click
  within "form.new_post" do
    page.fill_in "text", :with => @post_attrs[:text]
    page.find('input[type="submit"]').click
  end
end

Entonces /^el post aparecerá en el muro "([^\"]*)"$/ do |wall_name|
  within "#groups_panel" do
    page.click_link wall_name
  end
  within "#content_panel" do
    page.should have_content @post_attrs[:text]
  end
  visit root_path
  within "#groups_panel" do
    page.click_link wall_name
  end
  within "#content_panel" do
    page.should have_content @post_attrs[:text]
  end
end

Entonces /^el post no aparecerá en el muro "([^\"]*)"$/ do |wall_name|
  within "#groups_panel" do
    page.click_link wall_name
  end
  within "#content_panel" do
    page.should_not have_content @post_attrs[:text]
  end
  visit root_path
  within "#groups_panel" do
    page.click_link wall_name
  end
  within "#content_panel" do
    page.should_not have_content @post_attrs[:text]
  end
end
