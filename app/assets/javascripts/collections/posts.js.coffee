class Tutoriapps.Collections.Posts extends Backbone.Collection
  model: Tutoriapps.Models.Post

  initialize: (options) =>
    @groups = options.groups
    @groups.on('change_active', @changeGroup)

  changeGroup: (group) =>
    new_url = 'api/v1/groups/' + group.id + '/posts'
    if @url != new_url
      @url = new_url
      @fetch()
