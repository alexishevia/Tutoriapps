object @board_pic
attributes :id, :created_at
child :image => :image do
  attributes :url, :size, :content_type
end
child :author => :author do
  attributes :id, :name
end