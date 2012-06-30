class Tutoriapps.Views.Book extends Backbone.View
  template: SMT['books/book']
  className: 'book feed_item'

  initialize: ->
    @model.on('change', @render)
    @replies = new Tutoriapps.Collections.Replies([], {book: @model})
    @replies.fetch()

  events: =>
    'click .reply_link': 'showReplyForm'

  render: =>
    translations =
      t_reply: I18n.t('helpers.reply')
      t_offer_type: I18n.t('activerecord.attributes.book.offer_types.' + @model.get('offer_type'))
    hash = $.extend(translations, @model.toJSON())
    $(@el).html(@template(hash))
    if @model.get('reply_count') > 0
      @$('.post-options').remove()
    @$(".timeago").timeago()
    view = new Tutoriapps.Views.Replies(collection: @replies)
    @$('.data').append(view.render().el)
    this

  showReplyForm: (evt)=>
    evt.preventDefault()
    @$('form').show()