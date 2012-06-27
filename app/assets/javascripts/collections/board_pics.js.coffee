class Tutoriapps.Collections.BoardPics extends Backbone.Collection
  model: Tutoriapps.Models.BoardPic

  initialize: (options) =>
    @group = options.group
    @url = 'api/v1/groups/' + @group.id + '/board_pics'