# coding: utf-8
# language: es

Cuando /^intente compartir una foto$/ do
  click_button(I18n.t('helpers.submit.share', 
    :model => I18n.t('activerecord.models.board_pic')))
  within('form.new_board_pic') do
    page.attach_file('image', File.expand_path("#{Rails.root}/spec/support/rails.png"))
    page.find('input[type="submit"]').click
  end
end
