class Tutoriapps.Routers.Main extends Backbone.Router
  routes:
    '': 'index'

  initialize: (options) =>
    @is_admin = options.is_admin

  index: ->
    @user_groups = new Tutoriapps.Collections.Groups()
    @user_groups.fetch()
    if @is_admin
      @admin_groups = new Tutoriapps.Collections.AdminGroups()
      @admin_groups.fetch()
      view = new Tutoriapps.Views.AdminHomeView(admin_groups: @admin_groups,
        user_groups: @user_groups)
    else
      view = new Tutoriapps.Views.UserHomeView()
    $('#main_content').prepend(view.render().el)
