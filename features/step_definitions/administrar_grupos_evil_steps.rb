# coding: utf-8
# language: es

Cuando /^intente crear un grupo nuevo mediante http$/ do
  @group_attrs = attributes_for(:group)
  post groups_path, @group_attrs
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

