class Tutoriapps.Views.GroupsIndex extends Backbone.View

  template: SMT['groups/index']

  events:
    'click a.new_group': 'showNewGroupForm'
    'submit form.new_group': 'createGroup'

  initialize: ->
    @collection.on('add', @appendGroup)

  render: ->
    $(@el).html(@template())
    @$('a.new_group').next().hide()
    @collection.each(@appendGroup)
    this

  appendGroup: (group) =>
    view = new Tutoriapps.Views.Group(model: group)
    @$('#groups_list').append(view.render().el)

  createGroup: (evt) =>
    evt.preventDefault()
    data = Backbone.Syphon.serialize(evt.target);
    @collection.create data,
      wait: true
      success: -> 
        evt.target.reset()
        $(evt.target).hide()
        $(evt.target).prev().show()
      error: @handleError

  handleError: (group, response) ->
    if response.status = 422
      errors = $.parseJSON(response.responseText)
      alert errors[0]

  showNewGroupForm: (evt) ->
    evt.preventDefault()
    $(evt.target).hide().next().show('slow', 
      () -> $(this).find('input[type=text]').focus()
    )