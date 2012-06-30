object @reply
attributes :id, :text, :created_at
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