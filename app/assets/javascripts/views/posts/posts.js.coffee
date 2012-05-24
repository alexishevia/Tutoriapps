class Tutoriapps.Views.Posts extends Backbone.View
  className: 'posts'

  initialize: (options) =>
    @collection.on('reset', @render)

  render: =>
    @$el.empty()
    @collection.each(@addPost)
    this

  addPost: (post) =>
    view = new Tutoriapps.Views.Post(model: post)
    @$el.append(view.render().el)

  