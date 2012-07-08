class Tutoriapps.Views.LoadNewItems extends Backbone.View
  className: 'new_items'
  reloadTime: 10000

  events:
    'click': 'transferItems'

  initialize: (options) =>
    @user_id = options.user_id
    @buffer = new (@collection.constructor)([], {group: @collection.group})
    @buffer.on('reset', @render)
    @buffer.on('add', @render)
    @collection.on('reset', @newTimeoutFromCollection)
    @newTimeoutFromCollection()

  render: =>
    if @buffer.length > 0
      @$el.html( '<a href="#">' + I18n.t("helpers.new_items",
        {count: @buffer.length}) + '</a>')
    else
      @$el.empty()
    this

  loadNew: =>
    console.log('newer_than: ' + @ISODateString(@newest_date))
    new_items = new (@collection.constructor)([],
      group: @collection.group
      newer_than: @ISODateString(@newest_date)
      include_replies: true
    )
    new_items.fetch(
      success: (data)=>
        @newTimeout()
        data.each(
          (item) =>
            data = item.get('data')
            if data.owner.id != @user_id
              if item.get('type') == 'reply'
                @collection.addReply(new Tutoriapps.Models.Reply(data))
              else
                console.log('nuevo articulo: ' + @ISODateString(new Date(data.created_at)))
                @newTimeout(new Date(data.created_at))
                @buffer.add(item)
        )
    )

  transferItems: (evt) =>
    evt.preventDefault()
    @buffer.each(
      (item) =>
        if @collection not instanceof Tutoriapps.Collections.Items
          switch item.get('type')
            when 'post'
              item = new Tutoriapps.Models.Post(item.get('data'))
            when 'board_pic'
              item = new Tutoriapps.Models.BoardPic(item.get('data'))
            when 'book'
              item = new Tutoriapps.Models.Book(item.get('data'))
        @collection.add(item)
    )
    @buffer.reset()

  ISODateString: (d) ->
    pad = (n) -> if n < 10 then '0'+n else n
    d.getUTCFullYear() + '-' +
      pad(d.getUTCMonth()+1) + '-' +
      pad(d.getUTCDate()) + 'T' +
      pad(d.getUTCHours()) + ':' +
      pad(d.getUTCMinutes()) + ':' +
      pad(d.getUTCSeconds()) + '.' +
      pad(d.getUTCMilliseconds()) + 'Z'

  newTimeout: (new_date = new Date()) =>
    clearTimeout(@timeout)
    @newest_date ||= new_date
    if new_date > @newest_date
      @newest_date = new_date
    @timeout = setTimeout(@loadNew, @reloadTime)

  newTimeoutFromCollection: =>
    if first = @collection.first()
      created_at = first.get('created_at') || first.get('data').created_at
      @newTimeout(new Date(created_at))
    else
      @newTimeout()