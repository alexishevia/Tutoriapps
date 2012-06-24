class Tutoriapps.Views.Items extends Backbone.View
  className: 'items'

  initialize: (options) =>
    @collection.on('reset', @render)

  render: =>
    @$el.empty()
    @collection.each(@appendItem)
    this

  appendItem: (item) =>
    type = item.get('type')
    switch type
      when 'post'
        post = new Tutoriapps.Models.Post(item.get('data'))
        view = new Tutoriapps.Views.Post(model: post)
        @$el.append(view.render().el)
      when 'board_pic'
        board_pic = new Tutoriapps.Models.BoardPic(item.get('data'))
        view = new Tutoriapps.Views.BoardPicInFeed(model: board_pic)
        @$el.append(view.render().el)
      when 'book'
        book = new Tutoriapps.Models.Book(item.get('data'))
        view = new Tutoriapps.Views.Book(model: book)
        @$el.append(view.render().el)