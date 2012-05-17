class Tutoriapps.Views.Enrollment extends Backbone.View

  template: SMT['groups/enrollment']

  events:
    'click .delete_enrollment': 'delete'

  initialize: (options) ->
    @group = options.group

  render: ->
    $(@el).html(@template(@model.toJSON()))
    this

  delete: (evt) =>
    evt.preventDefault()
    if confirm("¿Desea sacar al usuario #{ @model.get('user_name')} del grupo #{@group.get('name')}?")
      @model.destroy()
      $(@el).find('.member').remove();