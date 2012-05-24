class Tutoriapps.Routers.Main extends Backbone.Router
  initialize: (options) =>
    @is_admin = options.is_admin

  routes:
    '': 'index'

  index: ->
    @groups = new Tutoriapps.Collections.Groups()
    @posts = new Tutoriapps.Collections.Posts(groups: @groups)
    @groups.fetch()
    view = new Tutoriapps.Views.Home({
      is_admin: @is_admin
      groups: @groups
      posts: @posts
    })
    $('#main_content').prepend(view.render().el)
