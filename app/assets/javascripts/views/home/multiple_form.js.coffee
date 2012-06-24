class Tutoriapps.Views.MultipleForm extends Backbone.View
  template: SMT['home/multiple_form']

  initialize: (options) =>
    @group = options.group
    @posts = options.posts
    @board_pics = options.board_pics
    @books = options.books
    @active_form = 'posts'

  events:
    'click a': 'change_active'

  render: =>
    @$el.html(@template())
    switch @active_form
      when 'posts'
        view = new Tutoriapps.Views.NewPost(collection: @posts)
      when 'board_pics'
        view = new Tutoriapps.Views.NewBoardPic(collection: @board_pics)
      when 'books'
        view = new Tutoriapps.Views.NewBook(collection: @books)
    @$el.append(view.render().el)
    this

  change_active: (evt) =>
    evt.preventDefault()
    @active_form = $(evt.target).attr('href')
    @render()