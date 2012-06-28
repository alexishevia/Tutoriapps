# coding: utf-8

Cuando /^facilite un libro$/ do
  @book_attrs = FactoryGirl.attributes_for(:book, :offer_type => 'gift')
  page.click_button(I18n.t('helpers.submit.share',
    :model => I18n.t('activerecord.models.book')))
  within('form.new_book') do
    @book_attrs.each do |key, value|
      if key.to_s == 'offer_type'
        page.select I18n.t("activerecord.attributes.book.offer_types.#{value}"),
          :from => key.to_s
      else
        page.fill_in key.to_s, :with => value
      end
    end
    page.find('input[type="submit"]').click
  end
end

Entonces /^el libro aparecerá en el muro "(.*?)"$/ do |wall_name|
  within "#groups_panel" do
    page.click_link wall_name
  end
  within "#content_panel" do
    page.should have_content @book_attrs[:title]
  end
  visit root_path
  within "#groups_panel" do
    page.click_link wall_name
  end
  within "#content_panel" do
    page.should have_content @book_attrs[:title]
  end
end

Entonces /^el libro no aparecerá en el muro "(.*?)"$/ do |wall_name|
  within "#groups_panel" do
    page.click_link wall_name
  end
  within "#content_panel" do
    page.should_not have_content @book_attrs[:title]
  end
  visit root_path
  within "#groups_panel" do
    page.click_link wall_name
  end
  within "#content_panel" do
    page.should_not have_content @book_attrs[:title]
  end
end