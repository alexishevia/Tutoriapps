class Tutoriapps.Views.LoadNewItems extends Backbone.View
  className: 'new_items'
  reloadTime: 15000

  events:
    'click': 'transferItems'

  initialize: (options) =>
    @user_id = options.user_id
    @buffer = new Tutoriapps.Collections.Items([], {group: @collection.group})
    @buffer.on('reset', @render)
    @buffer.on('add', @render)
    setInterval(@loadNew, @reloadTime)

  render: =>
    if @buffer.length > 0
      @$el.html( '<a href="#">' + I18n.t("helpers.new_items",
        {count: @buffer.length}) + '</a>')
    else
      @$el.empty()
    this

  loadNew: =>
    first = @buffer.first() || @collection.first()
    new_items = new Tutoriapps.Collections.Items( [],
      group: @collection.group
      newer_than: first.get('data').created_at
    )
    new_items.fetch(
      success: (data)=>
        data.each(
          (item) => @buffer.add(item) if item.get('data').owner.id != @user_id
        )
    )

  transferItems: (evt) =>
    evt.preventDefault()
    @buffer.each((item) => @collection.add(item))
    @buffer.reset()