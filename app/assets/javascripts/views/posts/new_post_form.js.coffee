class Tutoriapps.Views.NewPostForm extends Backbone.View
  className: 'newPostView'
  template: SMT['posts/new_post_form']

  initialize: (options) =>
    @collection.on('reset', @render)

  events:
    'submit form': 'createPost'
    'focus textarea': 'expand'
    'keyup textarea': 'toggleSubmitButton'

  render: =>
    translations =
      t_write_post: I18n.t('helpers.posts.write')
    $(@el).html(@template(translations))
    this

  createPost: (evt) =>
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

  expand: (evt) =>
    evt.preventDefault()
    form = $(evt.target).parents('form')
    $(form).addClass('focused')

  toggleSubmitButton: (evt) =>
    textarea = evt.target
    submit_button = $(evt.target).parents('form').find('input[type="submit"]')
    if (!$.trim($(textarea).val()))
      # textarea is empty or contains only white-space
      $(submit_button).addClass('disabled')
    else
      $(submit_button).removeClass('disabled')