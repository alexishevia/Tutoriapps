class Tutoriapps.Collections.Groups extends Backbone.Collection
  model: Tutoriapps.Models.Group
  url: '/api/v1/groups'

  initialize: =>
    @on('reset', @reset_active)

  reset_active: =>
    if !@active and first = @first()
      @set_active(first, 'all')

  set_active: (group, filter) =>
    @active_group = group
    @active_filter = filter
    @trigger('change_active', group, filter)