class Tutoriapps.Views.Feedback extends Backbone.View
  template: SMT['feedback/feedback']
  className: 'group'

  events: =>
    'submit form.new_feedback': 'createFeedback'
    'keyup textarea': 'toggleSubmitFeedbackButton'

  render: =>
    $(@el).html(@template())
    this

  createFeedback: (evt) =>
    evt.preventDefault()
    enabled = !$(evt.target).find('input[type="submit"]').hasClass('disabled')
    if(enabled)
      data = Backbone.Syphon.serialize(evt.target)
      f = new Tutoriapps.Models.Feedback(data)
      f.save(null,
        {
        success: ->
          template = SMT['alerts/success']
          translations = {
            t_message: I18n.t('helpers.messages.feedback_sent')
          }
          $('.navbar').after(template(translations))
          $(evt.target).find('textarea').val('')
          $(evt.target).parents('.modal').modal('hide')
        error: ->
          template = SMT['alerts/error']
          translations = {
            t_message: I18n.t('helpers.messages.feedback_error')
          }
          $('.navbar').after(template(translations))
          $(evt.target).parents('.modal').modal('hide')
        }
      )

  toggleSubmitFeedbackButton: (evt) =>
    textarea = evt.target
    submit_button = $(evt.target).parents('form').find('input[type="submit"]')
    if (!$.trim($(textarea).val()))
      # textarea is empty or contains only white-space
      $(submit_button).addClass('disabled')
    else
      $(submit_button).removeClass('disabled')