class Tutoriapps.Collections.Replies extends Backbone.Collection
  model: Tutoriapps.Models.Reply

  initialize: (options) =>
    @post = options.post
    @url = '/api/v1/posts/' + @post.id + '/replies'
