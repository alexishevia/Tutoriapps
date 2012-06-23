object @book
attributes :id, :author, :publisher, :additional_info, :contact_info, :created_at
child :owner => :owner do
  attributes :id, :name
end
node(:group) do |book|
  if book.group
    attributes :id => book.group.id, :name => book.group.name
  else
    attributes :id => 'home', :name => I18n.t('activerecord.attributes.group.public')
  end
end