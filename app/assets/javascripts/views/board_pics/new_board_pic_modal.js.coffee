class Tutoriapps.Views.NewBoardPicModal extends Backbone.View
  template: SMT['board_pics/new_board_pic_modal']
  className: 'new_board_pic'

  events:
    'submit form': 'createBoardPic'
    'change input': 'toggleSubmitButton'
    'changeDate input': 'toggleSubmitButton'

  render: =>
    translations =
      t_add_board_pic: I18n.t('helpers.submit.share',
        {model: I18n.t('activerecord.models.board_pic')})
      t_submit: I18n.t('helpers.submit.share1')
    hash = $.extend(translations, {group_id: @collection.group.id})
    $(@el).html(@template(hash))
    @$('.datepicker').datepicker()
    this

  createBoardPic: (evt)=>
    evt.preventDefault()
    enabled = !$(evt.target).find('input[type="submit"]').hasClass('disabled')
    if(enabled)
      $(evt.target).ajaxSubmit(
        success: (data) =>
          board_pic = new Tutoriapps.Models.BoardPic(data)
          @collection.add(board_pic)
          evt.target.reset()
          $(evt.target).parents('.modal').modal('hide')
      )

  toggleSubmitButton: (evt) =>
    form = $(evt.target).parents('form')
    ready = true
    $(form).find('input').each(
      (i, elem) ->
        if (!$.trim($(elem).val()))
          # input is empty or contains only white-space
          ready = false
    )
    if ready
      $(form).find('input[type="submit"]').removeClass('disabled')
    else
      $(form).find('input[type="submit"]').removeClass('enabled')