class Tutoriapps.Views.NewPost extends Backbone.View
  initialize: (options) =>
    @groups = options.groups
    @posts = options.posts
    @posts.on('reset', @render)

  events:
    'submit form': 'createPost'

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
    data = Backbone.Syphon.serialize(evt.target);
    @posts.create data,
      wait: true
      success: -> 
        evt.target.reset()
      error: @handleError

  handleError: (group, response) ->
    if response.status = 422
      errors = $.parseJSON(response.responseText)
      alert errors[0]
  