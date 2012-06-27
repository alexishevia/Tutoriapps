jQuery ($) ->
  $(document).ready ->
    $('.controls input').click(
      () ->
        $(this).css('border', '1px solid #CCC')
        $(this).css('color', '#555')
        $(this).siblings('.help-inline').hide()
    )