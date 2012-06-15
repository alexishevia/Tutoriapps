class Tutoriapps.Views.Post extends Backbone.View
  template: SMT['posts/post']
  className: 'post'

  initialize: ->
    @model.on('change', @render)
    @replies = new Tutoriapps.Collections.Replies({post: @model})
    @replies.fetch()

  render: =>
    $(@el).html(@template(@model.toJSON()))
    @$(".timeago").timeago()
    view = new Tutoriapps.Views.Replies(collection: @replies)
    $(@el).append(view.render().el)
    this