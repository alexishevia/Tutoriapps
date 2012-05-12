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
        evt.target.reset()
        $(evt.target).hide()
        $(evt.target).prev().show()
        new_group = $(data)
        bind_groups(new_group)
        $(evt.target).prev().before(new_group)
    )

    $('form.new_group').bind('ajax:error',
      (evt, xhr, status, error) ->
        alert(xhr.responseText)
    )

  bind_groups = (elem = '.groups') ->
    $(elem).find('.name .open').click(
      (evt) -> 
        evt.preventDefault()
        $(this).find('i').toggleClass('icon-chevron-down')
        $(this).parent().next().toggle('slow')
    ).parent().next().hide()

    $(elem).find('a.new_enrollment').click(
      (evt) -> 
        evt.preventDefault()
        $(this).hide()
        $(this).next().show('slow', 
          () -> $(this).find('input[type=text]').focus()
        )
    ).next().hide()

    $(elem).find('.best_in_place').best_in_place()

    $(elem).find('form.new_enrollment').bind('ajax:success'
      (evt, data, status, xhr) ->
        evt.target.reset()
        $(evt.target).hide()
        $(evt.target).prev().show()
        new_user = $(data)
        bind_users(new_user)
        $(evt.target).prev().before(new_user)
    )

    bind_users(elem)

    $(elem).find('form.new_enrollment').bind('ajax:error'
      (evt, xhr, status, error) ->
        alert(xhr.responseText)
    )

  bind_users = (elem) -> 
    $(elem).find('a.delete_enrollment').bind('ajax:success'
      (evt, data, status, xhr) ->
        $(evt.target).parent().remove()
    )