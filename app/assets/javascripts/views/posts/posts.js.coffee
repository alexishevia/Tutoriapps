class Tutoriapps.Views.Posts extends Backbone.View
  className: 'posts'

  initialize: (options) =>
    @collection.on('reset', @render)
    @collection.on('add', @prependPost)

  render: =>
    @$el.empty()
    @collection.each(@appendPost)
    this

  appendPost: (post) =>
    view = new Tutoriapps.Views.Post(model: post)
    @$el.append(view.render().el)

  prependPost: (post) =>
    view = new Tutoriapps.Views.Post(model: post)
    @$el.prepend(view.render().el)