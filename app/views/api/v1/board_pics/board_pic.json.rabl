object @board_pic
attributes :id, :class_date, :created_at
child :image => :image do
  attributes :url, :size, :content_type
  node :thumbnail_url do |img|
    img.url(:thumb)
  end
end
child :author => :author do
  attributes :id, :name
end
node(:group) do |post|
  if post.group
    attributes :id => post.group.id, :name => post.group.name
  else
    attributes :id => 'home', :name => I18n.t('activerecord.attributes.group.public')
  end
end