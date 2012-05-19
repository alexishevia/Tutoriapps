collection @groups
attributes :id, :name
child :enrollments => :enrollments do
  attributes :id
  child :user do
    attributes :id, :name
  end
end