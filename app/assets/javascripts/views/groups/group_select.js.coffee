class Tutoriapps.Views.GroupSelect extends Backbone.View
  tagName: 'ul'

  initialize: =>
    @collection.on('change_active', @render)

  render: =>
    @$el.empty()
    @collection.each(@appendButton)
    this

  appendButton: (group) =>
    view = new Tutoriapps.Views.GroupSelectButton(model: group)
    @$el.append(view.render().el)
    if group.get('id') == 'home'
      @$el.append("<h2>" + I18n.t('activerecord.models.groups') + "</h2>")