object @book
attributes :id, :title, :author, :publisher, :additional_info, :contact_info, :offer_type, :created_at
node(:price) do |book|
  book.price.to_f
end
child :owner => :owner do
  attributes :id, :name
  child :profile_pic => :profile_pic do
    attributes :url, :size, :content_type
    node :thumbnail_url do |img|
      img.url(:thumb)
    end
  end
end
node(:group) do |book|
  if book.group
    attributes :id => book.group.id, :name => book.group.name
  else
    attributes :id => 'home', :name => I18n.t('activerecord.attributes.group.public')
  end
end
node :reply_count do |post|
  post.replies.count
end