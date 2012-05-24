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