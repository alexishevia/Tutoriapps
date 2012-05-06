jQuery ($) ->
  $(document).ready ->
    $('.groups .name').click(
      () -> 
        $(this).next().toggle('slow')
        return false
    ).next().hide()