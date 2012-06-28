class Tutoriapps.Collections.BoardPics extends Backbone.Collection
  model: Tutoriapps.Models.BoardPic

  initialize: (options) =>
    @group = options.group
    @url = 'api/v1/groups/' + @group.id + '/board_pics?'
    if options.newer_than
      @url += '&newer_than=' + options.newer_than.id
    if options.older_than
      @url += '&older_than=' + options.older_than.id