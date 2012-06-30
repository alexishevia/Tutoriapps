class Tutoriapps.Collections.Replies extends Backbone.Collection
  model: Tutoriapps.Models.Reply

  initialize: (models, options) =>
    if options.post
      @post = options.post
      @url = '/api/v1/posts/' + @post.id + '/replies'
    else if options.book
      @post = options.book
      @url = '/api/v1/books/' + @post.id + '/replies'