class Tutoriapps.Views.GroupSelectButton extends Backbone.View
  template: SMT['groups/select_button']
  tagName: 'li'

  render: =>
    $(@el).html(@template(@model.toJSON()))
    if @model.collection.active_group == @model
      $(@el).find('a').addClass('active')
    this