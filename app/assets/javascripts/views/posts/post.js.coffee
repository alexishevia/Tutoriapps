class Tutoriapps.Views.Post extends Backbone.View
  template: SMT['posts/post']
  className: 'post'

  events:
    'click .reply': 'showReplyModal'

  render: =>
    translations =
      t_reply: I18n.t('helpers.reply')
      t_delete: I18n.t('helpers.delete')
    hash = $.extend(translations, @model.toJSON())
    $(@el).html(@template(hash))
    @$(".timeago").timeago()
    this

  showReplyModal: =>
    @model.collection.trigger('showReplyModal', @model)