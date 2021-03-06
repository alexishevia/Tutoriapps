class Tutoriapps.Views.FormSelect extends Backbone.View
  template: SMT['home/form_select']
  className: 'form_select'

  initialize: (options) =>
    @group = options.group
    @posts = options.posts
    @board_pics = options.board_pics
    @books = options.books
    @active_form = 'posts'

  events:
    'click a': 'change_active'

  render: =>
    translations =
      t_write_post: I18n.t('helpers.posts.write1')
      t_share_book: I18n.t('helpers.books.share')
      t_share_board_pic: I18n.t('helpers.board_pics.share')
    @$el.html(@template(translations))
    if @group.get('id') == 'home'
      @$('.board_pics').remove()
    switch @active_form
      when 'posts'
        view = new Tutoriapps.Views.NewPostForm(collection: @posts)
      when 'board_pics'
        view = new Tutoriapps.Views.NewBoardPicForm(collection: @board_pics)
      when 'books'
        view = new Tutoriapps.Views.NewBookForm(collection: @books)
    @$('.form-container').html(view.render().el)
    @$('.'+@active_form).addClass('active')
    this

  change_active: (evt) =>
    evt.preventDefault()
    @active_form = $(evt.target).attr('href')
    @render()