window.Tutoriapps =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: (options) ->
    new Tutoriapps.Routers.Main(options);
    if (!Backbone.history.started)
      Backbone.history.start();
      Backbone.history.started = true;
