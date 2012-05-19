window.Tutoriapps =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: (options) ->
    new Tutoriapps.Routers.Main(is_admin: options.is_admin);
    if (!Backbone.history.started)
      Backbone.history.start();
      Backbone.history.started = true;
