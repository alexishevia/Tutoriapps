class Tutoriapps.Views.Posts extends Backbone.View
  className: 'posts'

  initialize: (options) =>
    @groups = options.groups
    @groups.on('change_group', @changeGroup)

  changeGroup: () =>
    if group = @groups.active
      @posts = new Tutoriapps.Collections.Posts({group: group})
      @posts.on('reset', @render)
      @posts.fetch()

  render: =>
    if @posts
      @posts.each(@addPost)
    this

  addPost: (post) =>
    view = new Tutoriapps.Views.Post(model: post)
    @$el.append(view.render().el)

  