class Tutoriapps.Collections.Books extends Backbone.Collection
  model: Tutoriapps.Models.Book

  initialize: (options) =>
    @group = options.group
    @page = 1

  url: () =>
    'api/v1/groups/' + @group.id + '/books?per_page=1&page=' + @page