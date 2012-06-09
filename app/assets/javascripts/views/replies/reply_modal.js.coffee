class Tutoriapps.Views.ReplyModal extends Backbone.View
  template: SMT['replies/reply_modal']
  className: 'modal hide' 
  id: 'replyModal'

  initialize: (options) =>
    @posts = options.posts
    @posts.on('showReplyModal', @show)

  render: =>
    $(@el).html(@template(@post.toJSON()))
    $('#replyModal').modal('show')
    this

  show: (post) =>
    @post = post
    @render()