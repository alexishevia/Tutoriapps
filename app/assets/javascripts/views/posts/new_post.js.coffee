class Tutoriapps.Views.NewPost extends Backbone.View
  template: SMT['posts/new_post']

  initialize: (options) =>
    @groups = options.groups
    @groups.on('change_active', @render)

  render: =>
    if group = @groups.active
      $(@el).html(@template(group.toJSON()))
    this

  