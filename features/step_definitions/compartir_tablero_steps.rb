# coding: utf-8
# language: es

Dado /^eligió la opción de mostrar solo "(.*?)"$/ do |filter|
  page.find(:xpath, ".//*[contains(text(), '#{filter}')]").click
end

Cuando /^intente compartir una foto$/ do
  page.click_button(I18n.t('helpers.submit.share', 
    :model => I18n.t('activerecord.models.board_pic')))
  within('form#new_board_pic') do
    page.attach_file('board_pic[image]', File.expand_path("#{Rails.root}/spec/support/rails.png"))
    page.find('input[type="submit"]').click
  end
end

Entonces /^la foto será compartida$/ do
  page.find(:xpath, ".//img[contains(@src, 'rails.png')]")
end