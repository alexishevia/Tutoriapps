class Tutoriapps.Views.GroupSelectButton extends Backbone.View
  template: SMT['groups/select_button']
  tagName: 'li'

  render: =>
    if @model.collection.active_group == @model
      $(@el).addClass('active')
    $(@el).html(@template(@model.toJSON()))
    this