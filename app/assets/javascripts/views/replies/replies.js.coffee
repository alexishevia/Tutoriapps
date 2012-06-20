class Tutoriapps.Views.Replies extends Backbone.View
  className: 'replies'
  template: SMT['replies/replies']
  show: 'last_replies'

  initialize: =>
    @collection.on('reset', @render)
    @collection.on('add', @appendReply)

  events:
    'keyup textarea': 'toggleSubmitFeedbackButton'
    'submit form.new_reply': 'createReply'

  render: =>
    translations =
      t_see_all: I18n.t('helpers.comments.see_all')
      t_write_comment: I18n.t('helpers.comments.write')
    @$el.html(@template(translations))

    if @collection.length <= 0
      @$('form').hide()
    if @collection.length <= 2
      @$('.see_all').remove()

    if @show == 'last_replies'
      $(@collection.last(2)).each( (index, reply) => @appendReply(reply) )
    else if @show == 'all'
      @collection.each(@appendReply)
    this

  appendReply: (reply) =>
    view = new Tutoriapps.Views.Reply(model: reply)
    @$('.replies_container').append(view.render().el)

  createReply: (evt) =>
    evt.preventDefault()
    enabled = !$(evt.target).find('input[type="submit"]').hasClass('disabled')
    if(enabled)
      data = Backbone.Syphon.serialize(evt.target)
      @collection.create data,
      wait: true
      success: => 
        evt.target.reset()

  toggleSubmitFeedbackButton: (evt) =>
    textarea = evt.target
    submit_button = $(evt.target).parents('form').find('input[type="submit"]')
    if (!$.trim($(textarea).val()))
      # textarea is empty or contains only white-space
      $(submit_button).addClass('disabled')
    else
      $(submit_button).removeClass('disabled')  