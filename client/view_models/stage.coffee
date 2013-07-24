class @Stage
  defaults:
    width: 800
    height: 600

  constructor: (@gameSelector = "canvas") ->
    gb = $(@gameSelector)[0]
    (_ this).extend new createjs.Stage(gb)

    Session.set('game.width', gb.width)
    Session.set('game.height', gb.height)

    Deps.autorun @updateWidth
    Deps.autorun @updateHeight

    background = new createjs.Shape()
    background.graphics.beginFill("black").drawRect(0, 0, 2500, 2500)
    background.regX = 1000
    background.regY = 1000
    @addChild(background)

    createjs.Ticker.setFPS(40)
    createjs.Ticker.addEventListener "tick", (event) => @update()

  updateWidth: =>
    width = Session.get('game.width') || @defaults.width
    $(@gameSelector).attr('width', "#{width}px")
    @x = width/2

  updateHeight: =>
    height = Session.get('game.height') || @defaults.height
    @y = height/2
    $(@gameSelector).attr('height', "#{height}px")