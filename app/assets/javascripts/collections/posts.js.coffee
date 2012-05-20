class Tutoriapps.Collections.Posts extends Backbone.Collection
  initialize: (options) =>
    @url = 'api/v1/groups/' + options.group.id + '/posts'
  model: Tutoriapps.Models.Post