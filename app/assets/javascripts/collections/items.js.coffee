class Tutoriapps.Collections.Items extends Backbone.Collection
  model: Tutoriapps.Models.Item

  initialize: (options) =>
    @group = options.group
    @url = 'api/v1/groups/' + @group.id + '/all?'
    if options.newer_than
      @url += '&newer_than=' + options.newer_than
    if options.older_than
      @url += '&older_than=' + options.older_than