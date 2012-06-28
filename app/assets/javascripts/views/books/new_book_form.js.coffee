class Tutoriapps.Views.NewBookForm extends Backbone.View
  className: 'newBookView'
  template: SMT['books/new_book_form']

  initialize: (options) =>
    @collection.on('reset', @render)

  events:
    'submit form': 'createBook'
    'keyup textarea': 'toggleSubmitButton'
    'keyup input': 'toggleSubmitButton'
    'change select': 'toggleSubmitButton'

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
      t_borrow: I18n.t('activerecord.attributes.book.offer_types.borrow')
      t_loan: I18n.t('activerecord.attributes.book.offer_types.loan')
      t_sale: I18n.t('activerecord.attributes.book.offer_types.sale')
      t_submit: I18n.t('helpers.submit.share1')
    $(@el).html(@template(translations))
    this

  createBook: (evt) =>
    evt.preventDefault()
    enabled = !$(evt.target).find('input[type="submit"]').hasClass('disabled')
    if(enabled)
      data = Backbone.Syphon.serialize(evt.target)
      @collection.create data,
        wait: true
        success: ->
          evt.target.reset()
        error: @handleError
      $(evt.target).find('input[type="submit"]').addClass('disabled')

  handleError: (group, response) ->
    if response.status = 422
      errors = $.parseJSON(response.responseText)
      alert errors[0]

  toggleSubmitButton: (evt) =>
    form = $(evt.target).parents('form')
    valid = true
    $.each(['title', 'author', 'publisher', 'offer_type'],
      (i, name) =>
        val = $(form).find('[name="' + name + '"]').val()
        valid = !!$.trim(val)
        return false unless valid
    )

    offer_type = $(form).find('[name="offer_type"]').val()
    price_field = $(form).find('[name="price"]')

    if valid and (offer_type == 'sale' or offer_type == 'loan')
      valid = @isNumber($(form).find('[name="price"]').val())
    if valid
      $(form).find('input[type="submit"]').removeClass('disabled')
    else
      $(form).find('input[type="submit"]').addClass('disabled')

    if offer_type == '' or offer_type == 'gift' or offer_type == 'borrow'
      $(form).find('[name="price"]').val('').hide()
    else
      $(form).find('[name="price"]').show()

  isNumber: (n) ->
    !isNaN(parseFloat(n)) && isFinite(n)