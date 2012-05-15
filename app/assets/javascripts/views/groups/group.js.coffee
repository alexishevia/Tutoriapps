class Tutoriapps.Views.Group extends Backbone.View

  template: JST['groups/group']

  render: ->
    $(@el).html(@template(group: @model))
    this