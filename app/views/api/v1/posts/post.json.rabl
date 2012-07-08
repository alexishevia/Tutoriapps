object @post
attributes :id, :text, :created_at
node(:created_at) do |post|
  post.created_at.utc.iso8601(6)
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
node :reply_count do |post|
  post.replies.count
end