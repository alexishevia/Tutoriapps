class Tutoriapps.Views.Book extends Backbone.View
  template: SMT['books/book']
  className: 'book'

  initialize: ->
    @model.on('change', @render)

  render: =>
    translations =
      t_reply: I18n.t('helpers.reply')
    console.log(@model)
    hash = $.extend(translations, @model.toJSON())
    $(@el).html(@template(hash))
    this