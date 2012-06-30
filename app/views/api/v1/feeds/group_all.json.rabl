collection @feed_items
node :type do |item|
  item.class.to_s.underscore
end
node :data do |item|
  klass = item.class.to_s.underscore
  partial("api/v1/#{klass.pluralize}/#{klass}", :object => item)
end