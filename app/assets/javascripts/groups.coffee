jQuery ($) ->
  $(document).ready ->
    $('.group .name').click(
      (evt) -> 
        evt.preventDefault()
        $(this).find('i').toggleClass('icon-chevron-down')
        $(this).next().toggle('slow')
    ).next().hide()

    $('a.new_group, a.new_enrollment').click(
      (evt) -> 
        evt.preventDefault()
        $(this).hide()
        $(this).next().show('slow', 
          () -> $(this).find('input[type=text]').focus()
        )
    ).next().hide()

    $('form.new_group').bind('ajax:success',
      (evt, data, status, xhr) ->
        window.evt = evt
        window.data = data
        evt.target.reset()
        $(evt.target).hide()
        $(evt.target).prev().show()        
        new_group = $(data)
        bind_group(new_group)
        $(evt.target).prev().before(new_group)
    )

  bind_group = (elem) ->
    $(elem).find('.name').click(
      (evt) -> 
        evt.preventDefault()
        $(this).find('i').toggleClass('icon-chevron-down')
        $(this).next().toggle('slow')
    ).next().hide()