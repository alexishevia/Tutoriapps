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
    $(@el).html(@template(@model.toJSON()))
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
    attrs = 
      user_email: $(evt.target).find('.new_enrollment_email').val()
      group_id: @model.get('id')
    @enrollments.create attrs,
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
    if confirm("¿Desea eliminar el grupo #{@model.get('name')}?")
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