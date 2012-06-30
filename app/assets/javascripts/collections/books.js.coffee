class Tutoriapps.Collections.Books extends Backbone.Collection
  model: Tutoriapps.Models.Book

  initialize: (models, options) =>
    @group = options.group
    @url = 'api/v1/groups/' + @group.id + '/books?'
    if options.newer_than
      @url += '&newer_than=' + options.newer_than
    if options.older_than
      @url += '&older_than=' + options.older_than
    if options.include_replies
      @url += '&include_replies=1'

  addReply: (reply) =>
    @trigger('add_reply', reply)