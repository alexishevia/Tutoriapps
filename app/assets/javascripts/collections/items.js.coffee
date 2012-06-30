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
    if date = options.newer_than
      @url += '&newer_than=' + date
    if date = options.older_than
      @url += '&older_than=' + date
    if options.include_replies
      @url += '&include_replies=1'