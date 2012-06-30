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
    @base_url = 'api/v1/groups/' + @group.id + '/all?'
    @url = @base_url
    if date = options.newer_than
      @newer_than(date)
    if date = options.older_than
      @older_than(date)

  newer_than: (date) =>
    @url = @base_url + '&newer_than=' + date

  older_than: (date) =>
    @url = @base_url + '&older_than=' + date