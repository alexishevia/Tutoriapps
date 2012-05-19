collection @groups
attributes :id, :name
child :enrollments => :enrollments do
  attributes :id, :user_name
  child :user do
    attributes :id, :name
  end
end