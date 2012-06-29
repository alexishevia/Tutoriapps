class Tutoriapps.Routers.Main extends Backbone.Router
  initialize: (options) =>
    @is_admin = options.is_admin
    @groups = new Tutoriapps.Collections.Groups()

    if @is_admin
      view = new Tutoriapps.Views.AdminGroups(collection: @groups)
      $('#admin_panel').html(view.render().el)
    else
      $('#admin_panel').remove()

    view = new Tutoriapps.Views.GroupSelect(collection: @groups)
    $('#groups_panel .groups').html(view.render().el)

    view = new Tutoriapps.Views.FilterSelect(collection: @groups)
    $('#filter_selector').html(view.render().el)

    view = new Tutoriapps.Views.Feedback()
    $('body').append(view.render().el)

  routes:
    "" : "index"
    "groups/:id/:filter" : "showGroup"

  index: ->
    this.navigate('groups/home/all', {trigger: true})

  showGroup: (group_id, filter, tried_before = false) ->
    if group = @groups.get(group_id)
      @groups.set_active(group, filter)
      @showGroupContent(group, filter)
    else
      if tried_before
        console.log('Error. Group Id "' + group_id + '" not found inside @groups.')
      else
        @groups.fetch( success: => @showGroup(group_id, filter, true) )

  showGroupContent: (group, filter)=>
    $('#content').empty()
    switch filter
      when 'all'
        posts = new Tutoriapps.Collections.Posts(group: group)
        board_pics = new Tutoriapps.Collections.BoardPics(group: group)
        books = new Tutoriapps.Collections.Books(group: group)
        items = new Tutoriapps.Collections.Items(group: group)
        items.fetch()
        views = [
          new Tutoriapps.Views.FormSelect(
            group: group
            posts: posts
            board_pics: board_pics
            books: books
          )
          new Tutoriapps.Views.Items(
            collection: items
            posts: posts
            board_pics: board_pics
            books: books
          )
        ]

      when 'board_pics'
        board_pics = new Tutoriapps.Collections.BoardPics(group: group)
        board_pics.fetch()
        views = [
          new Tutoriapps.Views.NewBoardPicModal(collection: board_pics)
          new Tutoriapps.Views.BoardPics(collection: board_pics)
        ]

      when 'books'
        books = new Tutoriapps.Collections.Books(group: group)
        books.fetch()
        views = [
          new Tutoriapps.Views.NewBookModal(collection: books)
          new Tutoriapps.Views.Books(collection: books)
        ]

    for view in views
      $('#content').append(view.render().el)