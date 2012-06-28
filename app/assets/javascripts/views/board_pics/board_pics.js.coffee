class Tutoriapps.Views.BoardPics extends Backbone.View
  className: 'board_pics'
  template: SMT['board_pics/gallery']

  initialize: (options) =>
    @collection.on('reset', @render)
    @collection.on('add', @addBoardPic)
    $(window).on('scroll', @windowScroll)

  render: =>
    @$el.empty()
    @collection.each(@addBoardPic)
    this

  addBoardPic: (board_pic) =>
    return unless board_pic.id
    view = new Tutoriapps.Views.BoardPic(model: board_pic)
    gallery = @findGallery(board_pic.get('class_date'))
    if !gallery
      gallery = $(@template(date: board_pic.get('class_date')))
      @$el.append(gallery)
    $(gallery).find('[data-toggle="modal-gallery"]').prepend(view.render().el)

  findGallery: (date) =>
    found = null
    @$('.gallery').each(
      (index, gallery) =>
        if($(gallery).find('.date').html() == date)
          return found = gallery
    )
    return found

  windowScroll: =>
    if $(window).scrollTop() == $(document).height() - $(window).height()
      @loadMore()

  loadMore: =>
    older_pics = new Tutoriapps.Collections.BoardPics(
      group: @collection.group
      older_than: @collection.last()
    )
    older_pics.fetch(
      success: (data)=>
        if data.length == 0
          $(window).off('scroll')
        else
          data.each( (board_pic) => @collection.add(board_pic) )
    )