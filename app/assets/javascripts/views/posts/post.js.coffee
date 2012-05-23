class Tutoriapps.Views.Post extends Backbone.View
  template: SMT['posts/post']
  className: 'post'

  render: =>
    $(@el).html(@template(@model.toJSON()))
    @$(".timeago").timeago()
    this

  