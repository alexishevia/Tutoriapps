# coding: utf-8
# language: es

Cuando /^intente crear el grupo "([^\"]*)" mediante http$/ do |group_name|
  group_attrs = attributes_for(:group, :name => group_name)
  post groups_path, group_attrs
end


Cuando /^intente agregar el usuario "([^"]*)" al grupo "([^"]*)" mediante http$/ do |user_email, group_name|
  group = Group.find_by_name(group_name)
  post enrollments_path, {enrollment: {user_email: user_email, group_id: group.id}}
end

Cuando /^intente sacar al usuario "([^\"]*)" del grupo "([^\"]*)" mediante http$/ do |user_email, group_name|
  user = User.find_by_email(user_email)
  group = Group.find_by_name(group_name)
  enrollment = Enrollment.where('group_id = ?', group.id)
    .where('user_id = ?', user.id)[0]
  delete enrollment_path(enrollment.id)
end

Cuando /^intente cambiar el nombre del grupo "([^\"]*)" a "([^\"]*)" mediante http$/ do |group_name, new_group_name|
  group = Group.find_by_name(group_name)
  put group_path(group), {group: {name: new_group_name}}
end

Cuando /^intente eliminar el grupo "([^\"]*)" mediante http$/ do |group_name|
  group = Group.find_by_name(group_name)
  delete group_path(group)
end

Entonces /^el grupo "([^\"]*)" seguirá registrado en el sistema$/ do |group_name|
   Group.find_by_name(group_name).should_not be_nil
end

Entonces /^el grupo "([^\"]*)" no quedará registrado en el sistema$/ do |group_name|
  Group.find_by_name(group_name).should be_nil
end

Entonces /^el usuario "([^\"]*)" no aparecerá dentro del grupo "([^\"]*)" en el sistema$/ do |user_email, group_name|
  user = User.find_by_email(user_email)
  group = Group.find_by_name(group_name)
  group.members.exists?(user).should be_false
end

Entonces /^el usuario "([^\"]*)" aparecerá dentro del grupo "([^\"]*)" en el sistema$/ do |user_email, group_name|
  user = User.find_by_email(user_email)
  group = Group.find_by_name(group_name)
  group.members.exists?(user).should be_true
end

