class Tutoriapps.Views.AdminGroups extends Backbone.View
  template: SMT['groups/admin_groups']
  className: 'groups'

  events:
    'click a.new_group': 'showNewGroupForm'
    'submit form.new_group': 'createGroup'

  initialize: =>
    @collection.on('reset', @render)
    @collection.on('add', @appendGroup)

  render: =>
    translations = 
      t_groups: I18n.t('activerecord.models.groups')
      t_add_group: I18n.t('helpers.submit.add', model: I18n.t('activerecord.models.group'))
      t_group_name: I18n.t('activerecord.attributes.group.name')
      t_submit: I18n.t('helpers.submit.send')
    $(@el).html(@template(translations))
    @$('a.new_group').next().hide()
    @collection.each(@appendGroup)
    this

  appendGroup: (group) =>
    if group.get('id') != 'home'
      view = new Tutoriapps.Views.AdminGroup(model: group)
      @$('.groups_list').append(view.render().el)

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