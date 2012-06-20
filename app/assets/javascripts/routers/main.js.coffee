class Tutoriapps.Routers.Main extends Backbone.Router
  initialize: (options) =>
    @is_admin = options.is_admin
    @groups = new Tutoriapps.Collections.Groups()
    @posts = new Tutoriapps.Collections.Posts(groups: @groups)

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
    console.log(view.render)
    $('body').append(view.render().el)

  routes:
    "" : "index"
    "groups/:id/:filter" : "showGroup"

  index: ->
    this.navigate('groups/home/all', {trigger: true})

  showGroup: (group_id, filter) ->
    if group = @groups.get(group_id)
      @groups.set_active(group, filter)
    else
      @groups.fetch(
        success: =>
          @groups.set_active(@groups.get(group_id), filter)
      )

    views = [
      new Tutoriapps.Views.Posts(collection: @posts)
    ]
    $('#content').empty()
    for view in views
      $('#content').append(view.render().el)

    $('#groups_panel .newPostView'). remove()
    view = new Tutoriapps.Views.NewPost(groups: @groups, posts: @posts)
    $('#groups_panel').prepend(view.render().el)