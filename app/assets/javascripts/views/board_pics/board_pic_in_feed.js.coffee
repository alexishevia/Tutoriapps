class Tutoriapps.Views.BoardPicInFeed extends Backbone.View
  template: SMT['board_pics/board_pic_in_feed']
  className: 'board_pic'

  initialize: ->
    @model.on('change', @render)

  render: =>
    @$el.html(@template(@model.toJSON()))
    this