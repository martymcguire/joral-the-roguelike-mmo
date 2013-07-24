class @BiomeView
  constructor: (biome) ->
    (_ this).extend(new createjs.Shape())

    fillColor = switch biome.type
      when 'desert' then 'yellow'
      when 'grass'  then 'lightgreen'
      when 'forest' then 'darkgreen'
      when 'rock'   then 'gray'
      else 'purple'

    @graphics
      .beginFill(fillColor)
      .drawCircle(0, 0, biome.size)
    @x = biome.x
    @y = biome.y

  changed: (biome) ->
    # do nothing