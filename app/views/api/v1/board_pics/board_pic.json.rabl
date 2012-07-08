object @board_pic
attributes :id, :class_date
node(:created_at) do |obj|
  obj.created_at.utc.iso8601(3)
end
child :image => :image do
  attributes :url, :size, :content_type
  node :thumbnail_url do |img|
    img.url(:thumb)
  end
end
child :author => :author do
  attributes :id, :name
  child :profile_pic => :profile_pic do
    attributes :url, :size, :content_type
    node :thumbnail_url do |img|
      img.url(:thumb)
    end
  end
end
child :author => :owner do
  attributes :id, :name
  child :profile_pic => :profile_pic do
    attributes :url, :size, :content_type
    node :thumbnail_url do |img|
      img.url(:thumb)
    end
  end
end
node(:group) do |post|
  if post.group
    attributes :id => post.group.id, :name => post.group.name
  else
    attributes :id => 'home', :name => I18n.t('activerecord.attributes.group.public')
  end
end