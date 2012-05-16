class Tutoriapps.Views.Group extends Backbone.View

  template: SMT['groups/group']

  events:
    'click .name .open': 'showMembers'
    'click a.new_enrollment': 'showNewEnrollmentForm'

  render: ->
    $(@el).html(@template(@model.toJSON()))
    @$('.name .open').parent().next().hide()
    @$('a.new_enrollment').next().hide()
    this

  showMembers: (evt) ->
    evt.preventDefault()
    $(evt.target).find('i').toggleClass('icon-chevron-down')
    $(evt.target).parent().next().toggle('slow')

  showNewEnrollmentForm: (evt) ->
    evt.preventDefault()
    $(evt.target).hide().next().show('slow', 
      () -> 
        $(this).find('input[type=email]').focus()
    )