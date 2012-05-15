window.Tutoriapps =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    new Tutoriapps.Routers.Groups
    Backbone.history.start()

$(document).ready ->
  Tutoriapps.init()
