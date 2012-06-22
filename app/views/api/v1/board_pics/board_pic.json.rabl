object @board_pic
attributes :id, :class_date, :created_at
child :image => :image do
  attributes :url, :size, :content_type
end
child :author => :author do
  attributes :id, :name
end