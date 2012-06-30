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
    return unless date = board_pic.get('class_date')
    gallery = @findGallery(date)
    if !gallery
      t_date = @capitalize(I18n.l("date.formats.long", date))
      gallery = $(@template({date: date, t_date: t_date}))
      older_gallery = @findGalleryOlderThan(date)
      if older_gallery
        $(older_gallery).before(gallery)
      else
        @$el.append(gallery)
    view = new Tutoriapps.Views.BoardPic(model: board_pic)
    $(gallery).find('[data-toggle="modal-gallery"]').prepend(view.render().el)

  findGallery: (date) =>
    found = null
    @$('.gallery').each(
      (index, gallery) =>
        if($(gallery).find('.date').attr('data-iso') == date)
          found = gallery
          return false
    )
    return found

  findGalleryOlderThan: (date) =>
    found = null
    date = new Date(date)
    @$('.gallery').each(
      (index, gallery) =>
        gallery_date = new Date($(gallery).find('.date').attr('data-iso'))
        if( gallery_date < date)
          found = gallery
          return false
    )
    return found

  windowScroll: =>
    if $(window).scrollTop() == $(document).height() - $(window).height()
      @loadMore()

  loadMore: =>
    older_pics = new Tutoriapps.Collections.BoardPics(
      group: @collection.group
      older_than: @collection.last().get('class_date')
    )
    older_pics.fetch(
      success: (data)=>
        if data.length == 0
          $(window).off('scroll')
        else
          data.each( (board_pic) => @collection.add(board_pic) )
    )

  capitalize: (string) ->
    string.charAt(0).toUpperCase() + string.slice(1);