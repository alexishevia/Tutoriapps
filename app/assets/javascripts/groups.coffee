jQuery ($) ->
  $(document).ready ->
    bind_groups()

    $('a.new_group').click(
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
        bind_groups(new_group)
        $(evt.target).prev().before(new_group)
    )

  bind_groups = (elem = '.groups') ->
    $(elem).find('.name').click(
      (evt) -> 
        evt.preventDefault()
        $(this).find('i').toggleClass('icon-chevron-down')
        $(this).next().toggle('slow')
    ).next().hide()

    $(elem).find('a.new_enrollment').click(
      (evt) -> 
        evt.preventDefault()
        $(this).hide()
        $(this).next().show('slow', 
          () -> $(this).find('input[type=text]').focus()
        )
    ).next().hide()