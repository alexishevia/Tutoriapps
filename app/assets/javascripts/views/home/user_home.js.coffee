class Tutoriapps.Views.UserHomeView extends Backbone.View
  template: SMT['home/user']

  render: =>
    $(@el).html(@template())
    this