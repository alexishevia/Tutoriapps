class Tutoriapps.Routers.Main extends Backbone.Router
  routes:
    '': 'index'

  index: ->
    @collection = new Tutoriapps.Collections.Groups()
    @collection.fetch()
    view = new Tutoriapps.Views.GroupsIndex(collection: @collection)
    $('#admin_panel').append(view.render().el)