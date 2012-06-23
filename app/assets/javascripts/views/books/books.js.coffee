class Tutoriapps.Views.Books extends Backbone.View
  className: 'books'

  initialize: (options) =>
    @collection.on('reset', @render)
    @collection.on('add', @prependBook)

  render: =>
    @$el.empty()
    @collection.each(@appendBook)
    this

  appendBook: (book) =>
    if book.id
      view = new Tutoriapps.Views.Book(model: book)
      @$el.append(view.render().el)

  prependBook: (book) =>
    view = new Tutoriapps.Views.Book(model: book)
    @$el.prepend(view.render().el)