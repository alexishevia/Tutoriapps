object @post
attributes :id, :text, :created_at
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
node :reply_count do |post|
  post.replies.count
end
node :last_replies do |post|
  last_two = post.replies.order("replies.created_at DESC").limit(2)
  last_two.reverse.map { |reply| partial('api/v1/replies/reply', :object => reply) }
end