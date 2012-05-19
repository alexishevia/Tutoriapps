window.Tutoriapps =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: () ->
    new Tutoriapps.Routers.Main();
    if (!Backbone.history.started)
      Backbone.history.start();
      Backbone.history.started = true;
