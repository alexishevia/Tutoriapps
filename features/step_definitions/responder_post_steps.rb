#coding: utf-8

Dado /^se ha creado 1 post en el grupo "(.*?)"$/ do |group_name|
  group = Group.find_by_name(group_name)
  FactoryGirl.create(:post, :group => group)
end

Cuando /^intente responder un post$/ do
  @reply_attrs = attributes_for(:reply)
  within '.post:first' do
    page.click_link(I18n.t('helpers.reply'))
  end
  within '#replyModal' do
    page.fill_in "text", :with => @reply_attrs[:text]
    page.find('.btn-primary').click
  end
end

Cuando /^intente responder con un mensaje en blanco$/ do
  @reply_attrs = attributes_for(:reply)
  within '.post:first' do
    page.click_link(I18n.t('helpers.reply'))
  end
  within '#replyModal' do
    page.find('.btn-primary').click
  end
end

Entonces /^la respuesta será enviada$/ do
  page.should have_content(I18n.t('helpers.messages.reply_sent'))
end

Entonces /^no podrá enviar la respuesta$/ do
  page.should_not have_content(I18n.t('helpers.messages.reply_sent'))
  find('#replyModal')
end