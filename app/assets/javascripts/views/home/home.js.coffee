class Tutoriapps.Views.Home extends Backbone.View
  template: SMT['home/home']
  className: 'row'

  initialize: (options) =>
    @is_admin = options.is_admin

  render: =>
    $(@el).html(@template())
    if @is_admin
      view = new Tutoriapps.Views.AdminGroups(collection: @collection)
      @$('.admin_panel').append(view.render().el)
    else
      @$('.admin_panel').remove()
      @$('.content_panel').addClass('offset3')
    views = [
      new Tutoriapps.Views.GroupSelect(collection: @collection)
      new Tutoriapps.Views.NewPost(groups: @collection)
      new Tutoriapps.Views.Posts(groups: @collection)
    ]
    for view in views
      @$('.content_panel').append(view.el)  
    this