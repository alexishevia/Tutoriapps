class Tutoriapps.Views.FilterSelect extends Backbone.View
  template: SMT['groups/select_filter']
  tagName: 'ul'
  className: 'nav nav-tabs'

  events:
    'click .filter': 'activate'

  initialize: (options)=>
    @collection.on('change_filter', @render)

  render: =>
    $(@el).html(@template())
    this

  activate: (evt) =>
    evt.preventDefault()
    @collection.set_filter($(evt.target).attr('href'))