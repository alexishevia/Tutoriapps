jQuery ($) ->
  $(document).ready ->
    $('.new_post').live('ajax:success',
      (evt, data, status, xhr) ->
        evt.target.reset()
        $('.posts').prepend(data)
    )

    $('.timeline .change_group').live('ajax:success',
      (evt, data, status, xhr) ->
        # Load new posts
        $('.timeline').before(data).remove()
    )