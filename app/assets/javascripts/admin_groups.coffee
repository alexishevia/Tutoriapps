jQuery ($) ->
  $(document).ready ->
    bind_groups()

  bind_groups = (elem = '.groups') ->

    $(elem).find('form.new_enrollment').bind('ajax:success'
      (evt, data, status, xhr) ->
        evt.target.reset()
        $(evt.target).hide()
        $(evt.target).prev().show()
        new_user = $(data)
        bind_users(new_user)
        $(evt.target).prev().before(new_user)
    )

    $(elem).find('form.new_enrollment').bind('ajax:error'
      (evt, xhr, status, error) ->
        alert(xhr.responseText)
    )

    $(elem).find('.delete_group').bind('ajax:success',
      (evt) -> $(evt.target).closest('.group').remove()
    )

    bind_users(elem)

  bind_users = (elem) -> 
    $(elem).find('a.delete_enrollment').bind('ajax:success'
      (evt, data, status, xhr) ->
        $(evt.target).parent().remove()
    )