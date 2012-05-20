class Tutoriapps.Views.GroupSelectButton extends Backbone.View
  template: SMT['groups/select_button']
  tagName: 'li'

  render: =>
    if @model.get('active')
      $(@el).addClass('active')
    hash = @model.toJSON()
    $(@el).html(@template(hash))
    this