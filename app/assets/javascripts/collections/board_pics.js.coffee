class Tutoriapps.Collections.BoardPics extends Backbone.Collection
  model: Tutoriapps.Models.BoardPic

  initialize: (options) =>
    @url = 'api/v1/groups/' + options.group.id + '/board_pics'
    @fetch()