collection @groups
attributes :name
node(:id) do |group| 
  if group.id
    group.id
  else
    'home'
  end
end
child :enrollments => :enrollments do
  attributes :id, :user_name
  child :user do
    attributes :id, :name
  end
end