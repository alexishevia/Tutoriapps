class Tutoriapps.Views.Group extends Backbone.View

  template: SMT['groups/group']

  events:
    'click .name .open': 'showMembers'
    'click a.new_enrollment': 'showNewEnrollmentForm'
    'submit form.new_enrollment': 'createEnrollment'
    'click .delete_group': 'delete'
    'click .edit_group': 'editGroup'

  initialize: () ->
    @enrollments = new Tutoriapps.Collections.Enrollments(@model.get('enrollments'))
    @enrollments.on('add', @appendEnrollment)
    @model.on('change', @render)

  render: =>
    translations =
      t_add_user: I18n.t('helpers.submit.add', model: I18n.t('activerecord.models.user'))
      t_user_email: I18n.t('activerecord.attributes.enrollment.user_email')
      t_submit: I18n.t('helpers.submit.send')
    hash = $.extend(translations, @model.toJSON())
    $(@el).html(@template(hash))
    @$('.name .open').parent().next().hide()
    @$('a.new_enrollment').next().hide()
    @enrollments.each(@appendEnrollment)
    this

  showMembers: (evt) ->
    evt.preventDefault()
    link = $(evt.target).closest('a')
    $(link).find('i').toggleClass('icon-chevron-down')
    $(link).parent().next().toggle('slow')

  showNewEnrollmentForm: (evt) ->
    evt.preventDefault()
    $(evt.target).hide().next().show('slow', 
      () -> 
        $(this).find('input[type=email]').focus()
    )

  appendEnrollment: (enrollment) =>
    view = new Tutoriapps.Views.Enrollment(model: enrollment, group: @model)
    @$('.members').prepend(view.render().el)

  createEnrollment: (evt) =>
    evt.preventDefault()
    data = Backbone.Syphon.serialize(evt.target);
    @enrollments.create data,
      wait: true
      success: -> 
        evt.target.reset()
        $(evt.target).hide()
        $(evt.target).prev().show()
      error: @handleError

  handleError: (model, response) ->
    if response.status = 422
      errors = $.parseJSON(response.responseText)
      alert errors[0]

  delete: (evt) =>
    evt.preventDefault()
    if confirm(I18n.t('helpers.confirm_delete.group', group_name: @model.get('name')))
      @model.destroy()
      $(@el).find('.group').remove();

  editGroup: (evt) =>
    evt.preventDefault()
    @old_name = @$('.name span').text()
    input = $('<input type="text" name="name">').val(@old_name)
    @$('.name span').before(input).remove()
    @$('input').focus().keypress(
      (evt) =>
        if evt.keyCode == 13
          @updateGroup()
    )
    $(document).on('mouseup'
      (evt) =>
        evt.preventDefault()
        container = @el
        if $(@el).has(evt.target).length == 0
          @updateGroup()
    )

  updateGroup: (evt) =>
    new_name = @$('input').val()
    if @old_name != new_name
      @model.save({ name: new_name}
        wait: true
        error: () =>
          @handleError
          @render()
      )
    else
      @render()
    $(document).off('mouseup')