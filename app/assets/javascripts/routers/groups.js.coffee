class Tutoriapps.Routers.Groups extends Backbone.Router
  routes:
    '': 'index'
       
  initialize: ->
     @collection = new Tutoriapps.Collections.Groups()
     @collection.fetch()

  index: ->
    view = new Tutoriapps.Views.GroupsIndex(collection: @collection)
    $('.groups').append(view.render().el)