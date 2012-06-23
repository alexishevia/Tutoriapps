class Tutoriapps.Views.NewBook extends Backbone.View
  className: 'newBookView'
  template: SMT['books/new_book']

  initialize: (options) =>
    @collection.on('reset', @render)

  events:
    'submit form': 'createBook'

  render: =>
    translations =
      t_title: I18n.t('activerecord.attributes.book.title')
      t_author: I18n.t('activerecord.attributes.book.author')
      t_publisher: I18n.t('activerecord.attributes.book.publisher')
      t_additional_info: I18n.t('activerecord.attributes.book.additional_info')
      t_contact_info: I18n.t('activerecord.attributes.book.contact_info')
      t_price: I18n.t('activerecord.attributes.book.price')
      t_offer_type: I18n.t('activerecord.attributes.book.offer_type')
      t_gift: I18n.t('activerecord.attributes.book.offer_types.gift')
      t_loan: I18n.t('activerecord.attributes.book.offer_types.loan')
      t_sale: I18n.t('activerecord.attributes.book.offer_types.sale')
    $(@el).html(@template(translations))
    this

  createBook: (evt) =>
    evt.preventDefault()
    data = Backbone.Syphon.serialize(evt.target)
    @collection.create data,
      wait: true
      success: ->
        evt.target.reset()
      error: @handleError

  handleError: (group, response) ->
    if response.status = 422
      errors = $.parseJSON(response.responseText)
      alert errors[0]