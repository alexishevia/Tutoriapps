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
    $('#groups_panel').html(view.render().el)

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
        view = new Tutoriapps.Views.NewPost(collection: posts)
        $('#content').append(view.render().el)
        items = new Tutoriapps.Collections.Items(group: group)
        view = new Tutoriapps.Views.Items(collection: items)
        $('#content').append(view.render().el)

      when 'board_pics'
        board_pics = new Tutoriapps.Collections.BoardPics(group: group)
        view = new Tutoriapps.Views.NewBoardPic(collection: board_pics)
        $('#content').append(view.render().el)
        view = new Tutoriapps.Views.BoardPics(collection: board_pics)
        $('#content').append(view.render().el)

      when 'books'
        books = new Tutoriapps.Collections.Books(group: group)
        view = new Tutoriapps.Views.NewBook(collection: books)
        $('#content').prepend(view.render().el)
        view = new Tutoriapps.Views.Books(collection: books)
        $('#content').append(view.render().el)