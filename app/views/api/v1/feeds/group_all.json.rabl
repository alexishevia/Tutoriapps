collection @feed_items
node :type do |item|
  item.class.to_s.underscore
end
node :data do |item|
  case item.class.to_s.underscore
  when 'post'
    partial("api/v1/posts/post", :object => item)
  when 'board_pic'
    partial("api/v1/board_pics/board_pic", :object => item)
  when 'book'
    partial("api/v1/books/book", :object => item)
  end
end