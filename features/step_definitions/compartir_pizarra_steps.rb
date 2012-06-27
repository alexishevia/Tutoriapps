# coding: utf-8
# language: es

Dado /^eligió la opción de mostrar sólo "(.*?)"$/ do |filter|
  page.find(:xpath, ".//*[contains(text(), '#{filter}')]").click
end

Cuando /^intente compartir una pizarra$/ do
  page.click_button(I18n.t('helpers.submit.share',
    :model => I18n.t('activerecord.models.board_pic')))
  within('form#new_board_pic') do
    page.attach_file('board_pic[image]', File.expand_path("#{Rails.root}/spec/support/rails.png"))
    page.fill_in "board_pic[class_date]", :with => '2012-04-05'
    page.find('input[type="submit"]').click
  end
end

Cuando /^intente compartir una pizarra sin colocarle fecha$/ do
  page.click_button(I18n.t('helpers.submit.share',
    :model => I18n.t('activerecord.models.board_pic')))
  within('form#new_board_pic') do
    page.attach_file('board_pic[image]', File.expand_path("#{Rails.root}/spec/support/rails.png"))
    page.find('input[type="submit"]').click
  end
end

Cuando /^intente compartir una pizarra sin seleccionar el archivo$/ do
  page.click_button(I18n.t('helpers.submit.share',
    :model => I18n.t('activerecord.models.board_pic')))
  within('form#new_board_pic') do
    page.fill_in "board_pic[class_date]", :with => '2012-04-05'
    page.find('input[type="submit"]').click
  end
end

Entonces /^la pizarra será compartida$/ do
  page.find(:xpath, ".//img[contains(@src, 'rails.png')]")
end

Entonces /^no podrá compartir la pizarra$/ do
  page.should_not have_xpath(".//img[contains(@src, 'rails.png')]")
  page.should have_css('#new_board_pic input.disabled')
end