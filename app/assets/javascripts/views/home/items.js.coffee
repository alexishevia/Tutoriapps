class Tutoriapps.Views.Items extends Backbone.View
  className: 'items'

  initialize: (options) =>
    @add = 'before' # where to add new items
    @collection.on('reset', @render)
    @collection.on('add', @addItem)
    @collection.on('add_reply', @addReply)
    @posts = options.posts
    @posts.on('add', @addPost)
    @board_pics = options.board_pics
    @board_pics.on('add', @addBoardPic)
    @books = options.books
    @books.on('add', @addBook)
    $(window).on('scroll', @windowScroll)

  render: =>
    @$el.empty()
    @add = 'after'
    @collection.each(@addItem)
    @add = 'before'
    this

  addItem: (item) =>
    type = item.get('type')
    switch type
      when 'post'
        post = new Tutoriapps.Models.Post(item.get('data'))
        item.view = new Tutoriapps.Views.Post(model: post)
      when 'board_pic'
        board_pic = new Tutoriapps.Models.BoardPic(item.get('data'))
        item.view = new Tutoriapps.Views.BoardPicInFeed(model: board_pic)
      when 'book'
        book = new Tutoriapps.Models.Book(item.get('data'))
        item.view = new Tutoriapps.Views.Book(model: book)
    if item.view
      if @add == 'before'
        @$el.prepend(item.view.render().el)
      else if @add == 'after'
        @$el.append(item.view.render().el)

  addPost: (post) =>
    @collection.add({type:'post', data: post.toJSON()})

  addBoardPic:(board_pic) =>
    @collection.add({type:'board_pic', data: board_pic.toJSON()})

  addBook: (book) =>
    @collection.add({type:'book', data: book.toJSON()})

  windowScroll: =>
    if $(window).scrollTop() == $(document).height() - $(window).height()
      @loadOlder()

  loadOlder: =>
    older_items = new Tutoriapps.Collections.Items( [],
      {
        group: @collection.group
        older_than: @collection.last().get('data').created_at
      }
    )
    older_items.fetch(
      success: (data)=>
        if data.length == 0
          $(window).off('scroll')
        else
          @add = 'after'
          data.each( (item) => @collection.add(item) )
          @add = 'before'
    )

  addReply: (reply) =>
    type = reply.get('reply_to').type
    $.each( @collection.where({type: type}),
      (i, item) =>
        if item.get('data').id == reply.get('reply_to').id
          item.view.replies.add(reply)
          return false
    )