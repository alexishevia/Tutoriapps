# coding: utf-8
# lang: es

Dado /^PENDIENTE/ do
  pending
end

Cuando /^(acceda a|visite) la página de inicio$/ do |arg1|
  visit root_path
end

Cuando /^confirme|acepte el popup/ do
  if page.driver.browser.respond_to? 'switch_to' 
    page.driver.browser.switch_to.alert.accept    
  end
end

Cuando /^cierre el popup/ do
  if page.driver.browser.respond_to? 'switch_to' 
    page.driver.browser.switch_to.alert.dismiss
  end
end