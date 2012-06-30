class Tutoriapps.Views.LoadNewItems extends Backbone.View
  className: 'new_items'
  reloadTime: 5000

  events:
    'click': 'transferItems'

  initialize: (options) =>
    @user_id = options.user_id
    @buffer = new Tutoriapps.Collections.Items([], {group: @collection.group})
    @buffer.on('reset', @render)
    @buffer.on('add', @render)
    @newest_date = @ISODateString(new Date())
    setInterval(@loadNew, @reloadTime)

  render: =>
    if @buffer.length > 0
      @$el.html( '<a href="#">' + I18n.t("helpers.new_items",
        {count: @buffer.length}) + '</a>')
    else
      @$el.empty()
    this

  loadNew: =>
    new_items = new Tutoriapps.Collections.Items( [],
      group: @collection.group
      newer_than: @newest_date
      include_replies: true
    )
    new_items.fetch(
      success: (data)=>
        data.each(
          (item) =>
            @newest_date = @ISODateString(new Date())
            if item.get('data').owner.id != @user_id
              if item.get('type') == 'reply'
                @collection.addReply(new Tutoriapps.Models.Reply(item.get('data')))
              else
                @buffer.add(item)
        )
    )

  transferItems: (evt) =>
    evt.preventDefault()
    @buffer.each((item) => @collection.add(item))
    @buffer.reset()

  ISODateString: (d) ->
    pad = (n) -> if n < 10 then '0'+n else n
    d.getUTCFullYear() + '-' +
      pad(d.getUTCMonth()+1) + '-' +
      pad(d.getUTCDate()) + 'T' +
      pad(d.getUTCHours()) + ':' +
      pad(d.getUTCMinutes()) + ':' +
      pad(d.getUTCSeconds()) + 'Z'