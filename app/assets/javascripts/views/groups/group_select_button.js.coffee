class Tutoriapps.Views.GroupSelectButton extends Backbone.View
  template: SMT['groups/select_button']
  tagName: 'li'

  events:
    'click': 'activate'

  render: =>
    if @model.collection.active == @model
      $(@el).addClass('active')
    $(@el).html(@template(@model.toJSON()))
    this

  activate: =>
    @model.collection.set_active(@model)