object @reply
attributes :id, :text, :created_at
child :author => :author do
  attributes :id, :name
end