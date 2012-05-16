window.Tutoriapps =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: (data) ->
    this.groups = new Tutoriapps.Collections.Groups(data.groups);
    new Tutoriapps.Routers.Groups(collection: @groups)
    if (!Backbone.history.started)
      Backbone.history.start();
      Backbone.history.started = true;
