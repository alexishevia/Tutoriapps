collection @posts
attributes :id, :text, :created_at
child :author => :author do
  attributes :id, :name
end
child :group => :group do
  attributes :id, :name
end