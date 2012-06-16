class Tutoriapps.Collections.Groups extends Backbone.Collection
  model: Tutoriapps.Models.Group
  url: '/api/v1/groups'
  
  initialize: () =>
    @on('reset', @reset_active)
    @on('reset', @reset_filter)

  reset_active: =>
    if !@active and first = @first()
      @set_active(first)

  reset_filter: =>
    if !@active_filter
      @set_filter('all')

  set_active: (group) =>
    @active = group
    @trigger('change_active', group)

  set_filter: (filter) =>
    @active_filter = filter
    @trigger('change_filter', filter)