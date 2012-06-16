class Tutoriapps.Views.Reply extends Backbone.View
  className: 'reply'
  template: SMT['replies/reply']

  render: =>
    @$el.html(@template(@model.toJSON()))
    @$(".timeago").timeago()
    this