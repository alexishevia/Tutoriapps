class Tutoriapps.Routers.Main extends Backbone.Router
  initialize: (options) =>
    @is_admin = options.is_admin

  routes:
    '': 'index'

  index: ->
    @groups = new Tutoriapps.Collections.Groups()
    @groups.fetch()
    view = new Tutoriapps.Views.Home({
      collection: @groups
      is_admin: @is_admin
    })
    $('#main_content').prepend(view.render().el)
