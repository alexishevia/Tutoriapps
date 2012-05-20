class Tutoriapps.Views.Timeline extends Backbone.View
  template: SMT['home/timeline']

  initialize: (data) =>
    @groups = data.groups

  render: =>
    $(@el).html(@template())
    this