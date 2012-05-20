class Tutoriapps.Collections.Groups extends Backbone.Collection
  model: Tutoriapps.Models.Group
  url: '/api/v1/groups'
  
  initialize: () =>
    @on('reset', @reset_active)

  reset_active: =>
    if !@active and first = @first()
      @set_active(first)

  set_active: (group) =>
    @active = group
    @trigger('change_group')
