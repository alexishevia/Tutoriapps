class Tutoriapps.Views.NewBoardPic extends Backbone.View
  template: SMT['board_pics/new_board_pic']

  events:
    'submit form': 'createBoardPic'

  render: =>
    translations =
      t_add_board_pic: I18n.t('helpers.submit.share', {model: I18n.t('activerecord.models.board_pic')})
    $(@el).html(@template(translations))
    @$('.datepicker').datepicker()
    this

  createBoardPic: (evt)=>
    evt.preventDefault()
    $(evt.target).ajaxSubmit(
      success: (data) =>
        board_pic = new Tutoriapps.Models.BoardPic(data)
        @collection.add(board_pic)
        evt.target.reset()
    )