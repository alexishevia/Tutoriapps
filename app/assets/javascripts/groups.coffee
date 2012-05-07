jQuery ($) ->
  $(document).ready ->
    $('.group .name').click(
      () -> 
        $(this).next().toggle('slow')
        return false
    ).next().hide()