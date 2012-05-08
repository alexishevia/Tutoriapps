jQuery ($) ->
  $(document).ready ->
    $('.group .name').click(
      (evt) -> 
        evt.preventDefault()
        $(this).find('i').toggleClass('icon-chevron-down')
        $(this).next().toggle('slow')
    ).next().hide()

    $('a.new_group').click(
      (evt) -> 
        evt.preventDefault()
        $(this).hide()
        $(this).next().show('slow', 
          () -> $(this).find('input[type=text]').focus()
        )
    ).next().hide()

    $('form.new_group').bind('ajax:success',
      (evt, group, status, xhr) -> 
        window.evt = evt
        window.group = group
        $(evt.target).before($(group.name))
        $(evt.target).show
        $(evt.target).next().hide()
    )