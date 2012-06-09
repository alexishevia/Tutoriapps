class Tutoriapps.Views.ReplyModal extends Backbone.View
  template: SMT['replies/reply_modal']
  className: 'modal hide' 
  id: 'replyModal'

  events:
    'submit form.new_reply': 'createReply'

  initialize: (options) =>
    @posts = options.posts
    @posts.on('showReplyModal', @render)

  render: (post) =>
    @post = post
    $(@el).html(@template(@post.toJSON()))
    $('#replyModal').modal('show')
    this

  createReply: (evt) =>
    evt.preventDefault()
    enabled = !$(evt.target).find('input[type="submit"]').hasClass('disabled')
    if(enabled)
      data = Backbone.Syphon.serialize(evt.target)
      data.post = @post
      f = new Tutoriapps.Models.Reply(data)
      f.save(null,
        {
        success: ->
          template = SMT['alerts/success']
          translations = {
            t_message: I18n.t('helpers.messages.reply_sent')
          }
          $('.navbar').after(template(translations))
          $('#replyModal').modal('hide')
          $(evt.target).find('textarea').val('')
        error: ->
          template = SMT['alerts/error']
          translations = {
            t_message: I18n.t('helpers.messages.reply_error')
          }
          $('.navbar').after(template(translations))
          $('#replyModal').modal('hide')
        }
      )