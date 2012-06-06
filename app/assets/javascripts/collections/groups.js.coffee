class Tutoriapps.Collections.Groups extends Backbone.Collection
  model: Tutoriapps.Models.Group
  url: '/api/v1/groups'
  
  initialize: () =>
    @on('reset', @reset_active)

  initialize_filter: () =>
    @on('reset', @reset_filter)

  reset_active: =>
    if !@active and first = @first()
      @set_active(first)

  reset_filter: =>
    if !@filter and first = @first()
      @set_filter(first)

  set_active: (group) =>
    @active = group
    @trigger('change_active', group)

  set_filter: (group) =>
    @filter = filter
    @trigger('change_filter', filter)