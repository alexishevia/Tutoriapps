class Tutoriapps.Views.GroupSelect extends Backbone.View
  tagName: 'ul'
  className: 'nav nav-pills'

  initialize: =>
    @collection.on('change_group', @render)

  render: =>
    @collection.each(@appendButton)
    this

  appendButton: (group) =>
    view = new Tutoriapps.Views.GroupSelectButton(model: group)
    @$el.append(view.render().el)