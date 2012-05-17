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
    if confirm(I18n.t('helpers.confirm_delete.enrollment', user_name: @model.get('user_name'), group_name: @group.get('name')))
      @model.destroy()
      $(@el).find('.member').remove();