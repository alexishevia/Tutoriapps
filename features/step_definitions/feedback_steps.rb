#coding: utf-8

Cuando /^intente mandar un mensaje de feedback$/ do
  @feedback_attrs = attributes_for(:feedback)
  click_link(I18n.t('helpers.suggestions'))
  within '#myModal' do
    page.fill_in "text", :with => @feedback_attrs[:text]
    page.find('.btn-primary').click
  end
end

Cuando /^intente mandar un mensaje de feedback en blanco$/ do
  click_link(I18n.t('helpers.suggestions'))
  within '#myModal' do
    page.find('.btn-primary').click
  end
end

Entonces /^el mensaje será enviado$/ do
  page.should have_content(I18n.t('helpers.messages.feedback_sent'))
end

Entonces /^no podrá mandar el mensaje$/ do
  page.should_not have_content(I18n.t('helpers.messages.feedback_sent'))
  find('#myModal')
end