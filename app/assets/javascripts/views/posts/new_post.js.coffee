class Tutoriapps.Views.NewPost extends Backbone.View
  initialize: (options) =>
    @groups = options.groups
    @posts = options.posts
    @posts.on('reset', @render)

  events:
    'submit form': 'createPost'
    'focus textarea[name=text]': 'expand'

  render: =>
    if @groups.active.get('id') == 'home'
      template = SMT['posts/new_public_post']
      @$el.html(template(groups: @groups.toJSON()))
      @$('option[value=home]').html(I18n.t('activerecord.attributes.group.public'))
    else
      template = SMT['posts/new_group_post']
      @$el.html(template(@groups.active.toJSON()))
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
    button_container = $(textarea).next()
    $(textarea).animate({height: "5em"}, 200)
    $(button_container).toggle('slow',
      () =>
        $(document).on('mouseup'
          (evt) =>
            $(document).off('mouseup')
            evt.preventDefault()
            $(button_container).toggle()
            $(textarea).animate({height: "1.5em"}, 200)            
        )
    )

    
