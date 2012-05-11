# coding: utf-8
# language: es

Dado /^que el usuario "([^\"]*)" ya se agregó al grupo "([^\"]*)"$/ do |user_email, group_name|
  user = User.find_by_email(user_email)
  group = Group.find_by_name(group_name)
  if user
    group.members << user
  else
    group.enrollments.create(user_email: user_email)
  end
end

Dado /^que el grupo "([^\"]*)" ha sido creado$/ do |nombre|
  create(:group, :name => nombre)
end

Dado /^que el usuario "([^\"]*)" se ha agregado a (\d+) materias$/ do |user_email, n|
  user = User.find_by_email(user_email)
  n.to_i.times { create(:enrollment, :user => user) }
  user.groups.count.should eq(n)
end

Entonces /^podrá ver los grupos para las (\d+) materias en las que está matriculado$/ do |n|
  n = n.to_i
  @user.groups.count.should eq(n)
  for group in @user.groups
    page.should have_link(group.name)
  end
end