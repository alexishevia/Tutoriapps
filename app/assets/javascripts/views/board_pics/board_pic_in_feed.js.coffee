class Tutoriapps.Views.BoardPicInFeed extends Backbone.View
  template: SMT['board_pics/board_pic_in_feed']
  className: 'board_pic feed_item'

  initialize: ->
    @model.on('change', @render)

  render: =>
    translations =
      t_date: I18n.l("date.formats.short", @model.get('created_at'))
    hash = $.extend(translations, @model.toJSON())
    $(@el).html(@template(hash))
    @$(".timeago").timeago()
    this