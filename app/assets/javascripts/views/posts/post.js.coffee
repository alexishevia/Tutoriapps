class Tutoriapps.Views.Post extends Backbone.View
  template: SMT['posts/post']
  className: 'post'

  initialize: ->
    @model.on('change', @render)

  events:
    'click .reply': 'showReplyForm'
    'keyup textarea': 'toggleSubmitFeedbackButton'
    'submit form.new_reply': 'createReply'

  render: =>
    translations =
      t_reply: I18n.t('helpers.reply')
      t_delete: I18n.t('helpers.delete')
      t_see_all: I18n.t('helpers.comments.see_all')
    hash = $.extend(translations, @model.toJSON())
    $(@el).html(@template(hash))
    if @model.get('reply_count') <= 0
      @$('form').hide()
    if @model.get('reply_count') <= 2
      @$('.replies .see_all').remove()
    @$(".timeago").timeago()
    this

  showReplyForm: (evt)=>
    evt.preventDefault()
    @$('form').show()

  toggleSubmitFeedbackButton: (evt) =>
    textarea = evt.target
    submit_button = $(evt.target).parents('form').find('input[type="submit"]')
    if (!$.trim($(textarea).val()))
      # textarea is empty or contains only white-space
      $(submit_button).addClass('disabled')
    else
      $(submit_button).removeClass('disabled')   

  createReply: (evt) =>
    evt.preventDefault()
    enabled = !$(evt.target).find('input[type="submit"]').hasClass('disabled')
    if(enabled)
      data = Backbone.Syphon.serialize(evt.target)
      data.post = @model
      f = new Tutoriapps.Models.Reply(data)
      f.save(null,
        {
        success: =>
          template = SMT['alerts/success']
          translations = {
            t_message: I18n.t('helpers.messages.reply_sent')
          }
          $('.navbar').after(template(translations))
          $('#replyModal').modal('hide')
          $(evt.target).find('textarea').val('')
          @model.fetch()
        error: =>
          template = SMT['alerts/error']
          translations = {
            t_message: I18n.t('helpers.messages.reply_error')
          }
          $('.navbar').after(template(translations))
          $('#replyModal').modal('hide')
        }
      )