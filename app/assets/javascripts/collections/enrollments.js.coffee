class Tutoriapps.Collections.Enrollments extends Backbone.Collection
  model: Tutoriapps.Models.Enrollment
  url: 'api/v1/enrollments'
  initialize: =>
    this.bind('reset', () => console.log('funciona'))