class Tutoriapps.Collections.Items extends Backbone.Collection
  model: Tutoriapps.Models.Item

  comparator: (a, b) =>
    a = a.get('data').created_at
    b = b.get('data').created_at
    return -1 if a > b
    return 1 if a < b
    return 0

  initialize: (models, options) =>
    @group = options.group
    @url = 'api/v1/groups/' + @group.id + '/all?'
    if options.newer_than
      @url += '&newer_than=' + options.newer_than
    if options.older_than
      @url += '&older_than=' + options.older_than