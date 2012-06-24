class Tutoriapps.Collections.Posts extends Backbone.Collection
  model: Tutoriapps.Models.Post

  initialize: (options) =>
    @url = 'api/v1/groups/' + options.group.id + '/posts'