class Tutoriapps.Views.NewPost extends Backbone.View
  initialize: (options) =>
    @groups = options.groups
    @groups.on('change_active', @render)

  render: =>
    if @groups.active.get('id') == 'home'
      template = SMT['posts/new_public_post']
      @$el.html(template(groups: @groups.toJSON()))
      @$('option[value=home]').html(I18n.t('activerecord.attributes.group.public'))
    else
      template = SMT['posts/new_group_post']
      @$el.html(template(@groups.active.toJSON()))
    this

  