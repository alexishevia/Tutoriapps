class Tutoriapps.Views.Books extends Backbone.View
  className: 'books'

  initialize: (options) =>
    @collection.on('reset', @render)
    @collection.on('add', @prependBook)

  events:
    'click a.nextPage': 'nextPage'

  render: =>
    @$el.empty()
    @collection.each(@appendBook)
    @$el.append('<a href="#" class=".nextPage">Next</a>')
    this

  appendBook: (book) =>
    if book.id
      view = new Tutoriapps.Views.Book(model: book)
      @$el.append(view.render().el)

  prependBook: (book) =>
    view = new Tutoriapps.Views.Book(model: book)
    @$el.prepend(view.render().el)

  nextPage: (evt) =>
    evt.preventDefault()
    @collection.page += 1
    @collection.fetch({add:true})