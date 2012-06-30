class Tutoriapps.Collections.Posts extends Backbone.Collection
  model: Tutoriapps.Models.Post

  initialize: (models, options) =>
    @url = 'api/v1/groups/' + options.group.id + '/posts'