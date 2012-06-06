class Tutoriapps.Views.Home extends Backbone.View
  template: SMT['home/home']
  className: 'row'

  events: 
    'submit form.new_feedback': 'createFeedback'
    'keyup textarea': 'toggleSubmitFeedbackButton'

  initialize: (options) =>
    @is_admin = options.is_admin
    @groups = options.groups
    @posts = options.posts

  render: =>
    $(@el).html(@template())
    if @is_admin
      view = new Tutoriapps.Views.AdminGroups(collection: @groups)
      @$('.admin_panel').append(view.render().el)
    else
      @$('.admin_panel').remove()
      @$('.content_panel').addClass('offset3')
    views = [
      new Tutoriapps.Views.GroupSelect(collection: @groups)
      new Tutoriapps.Views.FilterSelect(collection: @groups)
      new Tutoriapps.Views.NewPost(groups: @groups, posts: @posts)
      new Tutoriapps.Views.Posts(collection: @posts)
    ]
    for view in views
      @$('.content_panel').append(view.el)  
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
          $('#myModal').modal('hide')
          $(evt.target).find('textarea').val('')
        error: ->
          template = SMT['alerts/error']
          translations = {
            t_message: I18n.t('helpers.messages.feedback_error')
          }
          $('.navbar').after(template(translations))
          $('#myModal').modal('hide')
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
