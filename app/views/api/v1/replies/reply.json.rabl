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
child :post => :reply_to do
  node :type do |item|
    item.class.to_s.underscore
  end
  attributes :id
end