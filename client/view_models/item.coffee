class @ItemView
  constructor: (item) ->
    (_ this).extend(new createjs.Shape())

    @type = item.type
    @x = item.x
    @y = item.y
    @scaleToAge(item.age)

    strategy = @getDrawStrategy(item.type)
    strokeColor = 'black'

    strategy(@graphics.beginStroke(strokeColor))

    this

  changed: (changes) ->
    @scaleToAge(changes.age) if changes.age?

  scaleToAge: (age) ->
    if @type == 'tree'
      scaleTo = (age * .05) + 1
      createjs.Tween.get(this, {}, {}, true)
        .to
          scaleX: scaleTo
          scaleY: scaleTo
        , 500

  getDrawStrategy: (type) ->
    switch type
      when 'boulder'
        (graphics) ->
          graphics
            .beginFill('darkgray')
            .drawRect(-10, -20, 15, 20)
      when 'tree'
        (graphics) ->
          graphics
            .beginFill('green')
            .moveTo(-10, 0)
            .lineTo(0, -30)
            .lineTo(10, 0)
            .lineTo(-10, 0)
            .closePath()
      when 'grass'
        (graphics) ->
          graphics
            .beginFill('lightgreen')
            .moveTo(-7, 0)
            .lineTo(-5, -8)
            .lineTo(-3, 0)
            .lineTo(-1, -8)
            .lineTo(1, 0)
            .lineTo(3, -8)
            .lineTo(5, 0)
            .closePath()
      else
        -> console.log "No Item view found for #{item.type}"