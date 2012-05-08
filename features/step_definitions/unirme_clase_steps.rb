# coding: utf-8
# language: es

Dado /^que se le han dado permisos de administrador$/ do
  @user ||= User.find_by_email(@user_attrs[:email])
  @user.admin = true
  @user.save!
end

Dado /^que el estudiante está matriculado en la materia "([^\"]*)"$/ do |nombre|
  group = create(:group, :name => nombre)
  group.members << @user
end

Cuando /^intente acceder al grupo "([^\"]*)"$/ do |nombre|
  group = Group.find_by_name(nombre)
  visit group_path(group)
end

Entonces /^podrá ver la información del grupo "([^\"]*)"$/ do |nombre|
  group = Group.find_by_name(nombre)
  page.should have_content(group.name)
end

Dado /^el estudiante no está matriculado en la materia "([^\"]*)"$/ do |nombre|
  group = Group.find_by_name(nombre)
  group.members.exists?(@user).should be_false
end

Dado /^que la clase "([^\"]*)" ha sido creada$/ do |nombre|
  create(:group, :name => nombre)
end

Entonces /^no podrá ver la información del grupo$/ do
  page.status_code.should eq(403)
end

Dado /^que el estudiante está matriculado en (\d+) materias$/ do |n|
  n = n.to_i
  n.times { create(:enrollment, :user => @user) }
  @user.groups.count.should eq(n)
end

Cuando /^entre a la página de inicio$/ do
  visit root_path
end

Entonces /^podrá ver los grupos para las (\d+) materias en las que está matriculado$/ do |n|
  n = n.to_i
  @user.groups.count.should eq(n)
  for group in @user.groups
    page.should have_link(group.name)
  end
end