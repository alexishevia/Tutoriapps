class Tutoriapps.Views.GroupsIndex extends Backbone.View

  template: JST['groups/index']

  events:
    'submit #new_group2': 'createGroup'

  initialize: ->
    @collection.on('reset', @render, this)
    @collection.on('add', @appendGroup, this)

  render: ->
    $(@el).html(@template(groups: @collection))
    @collection.each(@appendGroup)
    this

  appendGroup: (group) ->
    view = new Tutoriapps.Views.Group(model: group)
    $('#groups_list').append(view.render().el)

  createGroup: (evt) ->
    evt.preventDefault()
    attrs = name: $('#new_group_name').val()
    @collection.create attrs,
      wait: true
      success: -> $('#new_group2')[0].reset()
      error: @handleError

  handleError: (group, response) ->
    if response.status = 422
      errors = $.parseJSON(response.responseText)
      for error in errors
        alert error