class Tutoriapps.Views.Replies extends Backbone.View
  className: 'replies'
  template: SMT['replies/replies']
  show: 'last_replies'

  initialize: =>
    @collection.on('reset', @render)
    @collection.on('add', @appendReply)

  events:
    'submit form': 'createReply'
    'focus textarea': 'expand'
    'keyup textarea': 'toggleSubmitButton'
    'click .see_all': 'showAll'

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
      @$('.see_all').remove()
    this

  appendReply: (reply) =>
    view = new Tutoriapps.Views.Reply(model: reply)
    @$('.replies_container').append(view.render().el)

  showAll: (evt) =>
    evt.preventDefault()
    @show = 'all'
    @render()

  expand: (evt) =>
    evt.preventDefault()
    form = $(evt.target).parents('form')
    $(form).addClass('focused')

  createReply: (evt) =>
    evt.preventDefault()
    enabled = !$(evt.target).find('input[type="submit"]').hasClass('disabled')
    if(enabled)
      data = Backbone.Syphon.serialize(evt.target)
      @collection.create data,
        wait: true
        success: ->
          evt.target.reset()
          $(evt.target).removeClass('focused')
        error: @handleError

  handleError: (group, response) ->
    if response.status = 422
      errors = $.parseJSON(response.responseText)
      alert errors[0]

  toggleSubmitButton: (evt) =>
    textarea = evt.target
    submit_button = $(evt.target).parents('form').find('input[type="submit"]')
    if (!$.trim($(textarea).val()))
      # textarea is empty or contains only white-space
      $(submit_button).addClass('disabled')
    else
      $(submit_button).removeClass('disabled')