class Tutoriapps.Views.BoardPics extends Backbone.View
  className: 'board_pics'

  initialize: (options) =>
    @collection.on('reset', @render)
    @collection.on('add', @prependBoardPic)

  render: =>
    @$el.empty()
    @collection.each(@appendBoardPic)
    this

  appendBoardPic: (board_pic) =>
    if board_pic.id
      view = new Tutoriapps.Views.BoardPic(model: board_pic)
      @$el.append(view.render().el)

  prependBoardPic: (board_pic) =>
    if board_pic.id
      view = new Tutoriapps.Views.BoardPic(model: board_pic)
      @$el.prepend(view.render().el)