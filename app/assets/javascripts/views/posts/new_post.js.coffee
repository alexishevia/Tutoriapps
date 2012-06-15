class Tutoriapps.Views.NewPost extends Backbone.View
  initialize: (options) =>
    @groups = options.groups
    @posts = options.posts
    @posts.on('reset', @render)

  events:
    'submit form': 'createPost'
    'focus textarea[name=text]': 'expand'

  render: =>
    translations =
      t_write_post: I18n.t('helpers.posts.write')
    if @groups.active.get('id') == 'home'
      template = SMT['posts/new_public_post']
      hash = $.extend(translations, {groups: @groups.toJSON()})
      $(@el).html(template(hash))
      @$('option[value=home]').html(I18n.t('activerecord.attributes.group.public'))
    else
      template = SMT['posts/new_group_post']
      hash = $.extend(translations, @groups.active.toJSON())
      @$el.html(template(hash))
    this

  createPost: (evt) =>
    evt.preventDefault()
    data = Backbone.Syphon.serialize(evt.target)
    @posts.create data,
      wait: true
      success: -> 
        evt.target.reset()
      error: @handleError

  handleError: (group, response) ->
    if response.status = 422
      errors = $.parseJSON(response.responseText)
      alert errors[0]

  expand: (evt) =>
    evt.preventDefault()
    textarea = evt.target
    button_container = $(textarea).siblings(".hidden")
    $(textarea).animate({height: "5em"}, 200)
    $(button_container).show(0,
      () =>
        $("body").on('mouseup'
          (evt) =>
            if $(evt.target).parents('.new_post').length <= 0
              $("body").off('mouseup')
              evt.preventDefault()
              $(button_container).hide()
              $(textarea).animate({height: "1.5em"}, 200)            
        )
    )