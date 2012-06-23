class Tutoriapps.Collections.Books extends Backbone.Collection
  model: Tutoriapps.Models.Book

  initialize: (options) =>
    @url = 'api/v1/groups/' + options.group.id + '/books'
    @fetch()