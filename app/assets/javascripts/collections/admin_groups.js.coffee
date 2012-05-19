class Tutoriapps.Collections.AdminGroups extends Backbone.Collection
  model: Tutoriapps.Models.AdminGroup
  url: '/api/v1/groups'
  fetch: (options) =>
    options ||= {}
    options.url = '/api/v1/groups?admin=1'
    return Backbone.Collection.prototype.fetch.call(this, options);

