class Tutoriapps.Views.Books extends Backbone.View
  className: 'books'

  initialize: (options) =>
    @add = 'before' # where to add new books
    @collection.on('reset', @render)
    @collection.on('add', @addBook)
    $(window).on('scroll', @windowScroll)

  render: =>
    @$el.empty()
    @add = 'after'
    @collection.each(@appendBook)
    @add = 'before'
    this

  addBook: (book) =>
    if @add == 'before'
      @prependBook(book)
    else if @add == 'after'
      @appendBook(book)
    else
      console.log('ERROR: @add value is not valid: ' + @add)

  appendBook: (book) =>
    if book.id
      view = new Tutoriapps.Views.Book(model: book)
      @$el.append(view.render().el)

  prependBook: (book) =>
    view = new Tutoriapps.Views.Book(model: book)
    @$el.prepend(view.render().el)

  windowScroll: =>
    if $(window).scrollTop() == $(document).height() - $(window).height()
      @loadMore()

  loadMore: =>
    older_books = new Tutoriapps.Collections.Books(
      group: @collection.group
      older_than: @collection.last()
    )
    older_books.fetch(
      success: (data)=>
        if data.length == 0
          $(window).off('scroll')
        else
          @add = 'after'
          data.each( (book) => @collection.add(book) )
          @add = 'before'
    )