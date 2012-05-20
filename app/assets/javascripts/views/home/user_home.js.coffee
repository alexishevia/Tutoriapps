class Tutoriapps.Views.UserHome extends Backbone.View
  template: SMT['home/user']

  render: =>
    $(@el).html(@template())
    this