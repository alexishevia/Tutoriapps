class Tutoriapps.Views.BoardPic extends Backbone.View
  template: SMT['board_pics/board_pic']
  className: 'board_pic'

  initialize: ->
    @model.on('change', @render)

  render: =>
    $(@el).html(@template(@model.toJSON()))
    this