class Tutoriapps.Views.AdminEnrollment extends Backbone.View
  template: SMT['groups/admin_enrollment']
  className: 'member'

  events:
    'click .delete_enrollment': 'delete'

  initialize: (options) ->
    @group = options.group
    @model.on('destroy', @close);

  render: ->
    $(@el).html(@template(@model.toJSON()))
    this

  close: () =>
    $(@el).unbind()
    $(@el).remove()

  delete: (evt) =>
    evt.preventDefault()
    if confirm(I18n.t('helpers.confirm_delete.enrollment', user_name: @model.get('user_name'), group_name: @group.get('name')))
      @model.destroy()