class Tutoriapps.Routers.Groups extends Backbone.Router
  routes:
    '': 'index'
       
  initialize: (options) ->
     @collection = options.collection

  index: ->
    view = new Tutoriapps.Views.GroupsIndex(collection: @collection)
    $('#admin_panel').append(view.render().el)