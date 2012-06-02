class Tutoriapps.Views.Home extends Backbone.View
  template: SMT['home/home']
  className: 'row'

  initialize: (options) =>
    @is_admin = options.is_admin
    @groups = options.groups
    @posts = options.posts

  render: =>
    $(@el).html(@template())
    if @is_admin
      view = new Tutoriapps.Views.AdminGroups(collection: @groups)
      @$('.admin_panel').append(view.render().el)
    else
      @$('.admin_panel').remove()
      @$('.content_panel').addClass('offset3')
    views = [
      new Tutoriapps.Views.GroupSelect(collection: @groups)
      new Tutoriapps.Views.NewPost(groups: @groups, posts: @posts)
      new Tutoriapps.Views.Posts(collection: @posts)
    ]
    for view in views
      @$('.content_panel').append(view.el)  
    this
    
    
