class Tutoriapps.Collections.Items extends Backbone.Collection
  model: Tutoriapps.Models.Item

  initialize: (options) =>
    @url = 'api/v1/groups/' + options.group.id + '/all'
    @fetch()