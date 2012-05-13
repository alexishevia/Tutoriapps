jQuery ($) ->
  $(document).ready ->
    $('.new_post').bind('ajax:success',
      (evt, data, status, xhr) ->
        evt.target.reset()
        $('.posts').prepend(data)
    )

    $('.timeline .change_group').bind('ajax:success',
      (evt, data, status, xhr) ->
        $('.timeline .posts').html(data)
        $('.change_group').each(
          (index, elem) ->
            $(elem).closest('li').removeClass('active')
        )
        $(evt.target).closest('li').addClass('active')
    )