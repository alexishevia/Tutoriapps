class Tutoriapps.Views.FilterSelect extends Backbone.View
  template: SMT['groups/select_filter']
  tagName: 'ul'
  className: 'nav nav-tabs'

  events:
    'click a': 'activate'

  initialize: =>
    @render()

  render: =>
    $(@el).html(@template())
    this

  activate: (evt) =>
    console.log(evt)