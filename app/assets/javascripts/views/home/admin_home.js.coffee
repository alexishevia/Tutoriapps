class Tutoriapps.Views.AdminHomeView extends Backbone.View
  template: SMT['home/admin']

  initialize: (data) =>
    @user_groups = data.user_groups
    @admin_groups = data.admin_groups

  render: =>
    $(@el).html(@template())
    view = new Tutoriapps.Views.AdminGroups(collection: @admin_groups)
    @$('#admin_panel').append(view.render().el)
    this