class Tutoriapps.Views.GroupSelect extends Backbone.View
  tagName: 'ul'
  className: 'nav nav-pills'

  initialize: =>
    @collection.on('reset', @render)

  render: =>
    @collection.each(@appendButton)
    this

  appendButton: (group) =>
    model = group
    model.set('active', @collection.is_active(group))
    view = new Tutoriapps.Views.GroupSelectButton(model: model)
    @$el.append(view.render().el)