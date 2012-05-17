# coding: utf-8
# language: es

Dado /^que el grupo "([^\"]*)" ha sido creado$/ do |group_name|
  create(:group, :name => group_name)
end

Dado /^que los grupos \[([^\]]*)\] han sido creados$/ do |group_names|
  for group_name in group_names.split(', ') do
    step "que el grupo \"#{group_name}\" ha sido creado"
  end
end

Dado /^que el usuario "([^\"]*)" ya fue agregado al grupo "([^\"]*)"$/ do |user_email, group_name|
  user = User.find_by_email(user_email)
  group = Group.find_by_name(group_name)
  if user
    group.members << user
  else
    group.enrollments.create(user_email: user_email)
  end
end

Dado /^que las siguientes matrículas han sido creadas:$/ do |table|
  for hash in table.hashes do
    for email in hash[:usuarios].split(', ') do
      step "que el usuario \"#{email}\" ya fue agregado al grupo \"#{hash[:grupo]}\""
    end
  end 
end

Cuando /^intente crear el grupo "([^\"]*)"$/ do |group_name|
  group_attrs = attributes_for(:group, :name => group_name)
  visit root_path
  click_link(I18n.t('helpers.submit.add', 
      :model => I18n.t('activerecord.models.group')))
  within ("form.new_group") do
    find("[placeholder='#{ I18n.t('activerecord.attributes.group.name') }']")
      .set(group_attrs[:name])
    click_button I18n.t('helpers.submit.send')
  end
end

Entonces /^el grupo "([^\"]*)" aparecerá (\d+) (vez|veces) en la lista de grupos$/ do |group_name, n, arg3|
  within ".groups" do
    page.should have_content(group_name)
    page.text.scan(group_name).length.should eq(n.to_i)
  end
end

Entonces /^el grupo "([^\"]*)" no aparecerá en la lista de grupos$/ do |group_name|
  within ".groups" do
    page.should_not have_content(group_name)
  end
end

Cuando /^intente agregar el usuario "([^"]*)" al grupo "([^"]*)"$/ do |user_email, group_name|
  group = Group.find_by_name(group_name)
  visit root_path
  within find_link(group_name).find(:xpath,".//ancestor::*[contains(@class, 'group')]") do
    click_link(group_name)
    click_link I18n.t('helpers.submit.add', 
      :model => I18n.t('activerecord.models.user'))
    find(".new_enrollment input[placeholder='#{ I18n.t(
      'activerecord.attributes.enrollment.user_email') }']").set(user_email)
    click_button I18n.t('helpers.submit.send')
  end
end

Entonces /^el usuario "([^"]*)" aparecerá dentro del grupo "([^"]*)"$/ do |user_email, group_name|
  group = Group.find_by_name(group_name)
  user = User.find_by_email(user_email) || User.new(name: user_email)
  within find_link(group_name).find(:xpath,".//ancestor::*[contains(@class, 'group')]") do
    page.should have_content(user.name)
  end
end

Entonces /^el usuario "([^\"]*)" no aparecerá dentro del grupo "([^\"]*)"$/ do |user_email, group_name|
  group = Group.find_by_name(group_name)
  user = User.find_by_email(user_email) || User.new(name: user_email)
  within find_link(group_name).find(:xpath,".//ancestor::*[contains(@class, 'group')]") do
    page.should_not have_content(user.name)
  end
end

Entonces /^recibirá el status (\d+)$/ do |code|
  last_response.status.should eq(code.to_i)
end

Entonces /^el usuario "([^"]*)" aparecerá (\d+) vez en el grupo "([^\"]*)"$/ do |user_email, n, group_name|
  user = User.find_by_email(user_email) || User.new(name: user_email)
  within find_link(group_name).find(:xpath,".//ancestor::*[contains(@class, 'group')]") do
    page.find('.members').text.scan(user.name).length.should eq(n.to_i)
  end
end

Cuando /^intente sacar al usuario "([^\"]*)" del grupo "([^\"]*)"$/ do |user_email, group_name|
  user = User.find_by_email(user_email) || User.new(name: user_email)
  visit root_path
  click_link(group_name)
  find_link(group_name).find(:xpath,".//ancestor::*[contains(@class, 'group')]")
    .find(:xpath, ".//*[contains(text(), '#{user.name}')]").find(:xpath,".//..")
    .find(:xpath, './a[1]').click
end

Cuando /^intente cambiar el nombre del grupo "([^"]*)" a "([^"]*)"$/ do |group_name, new_group_name|
  within find_link(group_name).find(:xpath,".//..") do
    page.find('.edit_group').click
    fill_in 'name', with: new_group_name
  end
  page.find('body').click
end

Cuando /^intente eliminar el grupo "([^\"]*)"$/ do |group_name|
  within find_link(group_name).find(:xpath,".//..") do
    page.find('.delete_group').click
  end
end
