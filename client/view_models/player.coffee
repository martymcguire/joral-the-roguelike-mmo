class @PlayerView
  constructor: (player) ->
    (_ this).extend(new createjs.Container())
    @_observers = []

    @name = player.name
    @changed(player, false)

    @playerName = new createjs.Text(@name, "9px Arial")
    @playerName.x = -10
    @playerName.y = -30
    @addChild(@playerName)

    @playerImage = new createjs.Bitmap('/images/wilson.png')
    @playerImage.regX = 50
    @playerImage.regY = 228
    @playerImage.scaleX = @playerImage.scaleY = .10
    @addChild(@playerImage)

  changed: (player, smooth = true) ->
    @playerName.text = player.name if player.name? and @playerName?

    if player.x? or player.y?
      if smooth
        tween = createjs.Tween.get(this)
          .to
            x: player.x
            y: player.y
          , 1000
          
        tween.addEventListener 'change', => @notifyObservers()
      else
        @x = player.x
        @y = player.y

  addObserver: (observer) ->
    @_observers.push(observer)

  notifyObservers: ->
    observer.notify(this) for observer in @_observers
