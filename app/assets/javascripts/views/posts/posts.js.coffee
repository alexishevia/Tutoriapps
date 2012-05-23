class Tutoriapps.Views.Posts extends Backbone.View
  className: 'posts'

  initialize: (options) =>
    @groups = options.groups
    @groups.on('change_active', @changeGroup)

  changeGroup: (group) =>
    @posts = new Tutoriapps.Collections.Posts({group: group})
    @posts.on('reset', @render)
    @posts.fetch()

  render: =>
    @$el.empty()
    @posts.each(@addPost)
    this

  addPost: (post) =>
    view = new Tutoriapps.Views.Post(model: post)
    @$el.append(view.render().el)

  