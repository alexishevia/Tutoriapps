class Tutoriapps.Views.FilterSelect extends Backbone.View
  template: SMT['groups/select_filter']
  tagName: 'ul'
  className: 'nav nav-tabs'

  initialize: (options)=>
    @collection.on('change_active', @render)

  render: =>
    current_group = @collection.active_group
    if !current_group
      return this
    @$el.html(@template({
      url: '#groups/'+  current_group.get('id'),
      name: current_group.get('name')
    }))
    @$('li.' + @collection.active_filter).addClass('active')
    this