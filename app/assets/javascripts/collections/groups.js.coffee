class Tutoriapps.Collections.Groups extends Backbone.Collection
  model: Tutoriapps.Models.Group
  url: '/api/v1/groups'

  initialize: =>
    @active = @first()

  is_active: (group) =>
    if !@active
      @active = @first()
    group == @active
