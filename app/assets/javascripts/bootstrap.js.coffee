jQuery ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()
  $('form.dropdown-menu').click( (e) -> e.stopPropagation() )