class Tutoriapps.Models.Reply extends Backbone.Model
  url: '/api/v1/posts/id/replies'

  initialize: (options) =>
    @url = @url.replace('id', options.post.id)