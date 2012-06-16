class Tutoriapps.Views.Post extends Backbone.View
  template: SMT['posts/post']
  className: 'post'

  initialize: ->
    @model.on('change', @render)
    @replies = new Tutoriapps.Collections.Replies({post: @model})
    @replies.fetch()

  events: =>
    'click .reply_link': 'showReplyForm'

  render: =>
    translations =
      t_reply: I18n.t('helpers.reply')
    hash = $.extend(translations, @model.toJSON())
    $(@el).html(@template(hash))
    if @model.get('reply_count') > 0
      @$('.post-options').remove()
    @$(".timeago").timeago()
    view = new Tutoriapps.Views.Replies(collection: @replies)
    $(@el).append(view.render().el)
    this

  showReplyForm: (evt)=>
    evt.preventDefault()
    @$('form').show()