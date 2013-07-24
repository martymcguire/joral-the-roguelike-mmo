@Biome = new Meteor.Collection "biomes"

Biome.types = [ 'desert', 'grass', 'forest', 'rock' ]

Biome.randomType = -> (_ Biome.types).shuffle()[0]

Biome.randomItemFor = (biome) ->
  item = { biomeId: biome._id }
  item.type = switch biome.type
    when 'grass', 'forest' then 'tree'
    when 'rock' then 'boulder'
    when 'desert' then 'grass'
    else 'sapling'

  range    = biome.size*.8
  item.x   = _.random(-range, range) + biome.x
  item.y   = _.random(-range, range) + biome.y
  item.age = _.random(1, 6)

  Item.insert item

Biome.resetBiosphere = ->
  Biome.destroyBiosphere()
  Biome.generateBiosphere()

Biome.destroyBiosphere = ->
  Biome.remove({})
  Item.remove({})
  Player.remove({})

Biome.generateBiosphere = () ->
  console.log "=== Creating Biomes ==="
  @generateBiomes()
  console.log "=== Generated #{Biome.find().count()} Biomes ==="
  @generateItems()
  console.log "=== Generated #{Item.find().count()} Items ==="
  @placePlayers()
  console.log "=== Helped #{Player.find().count()} Players Find Their Way ==="

Biome.generateBiomes = ->
  randomGrowth = ->  .5 + Math.random() *   .2
  randomSize   = -> 100 + Math.random() *   30
  randomX      = ->       Math.random() * 1440
  randomY      = ->       Math.random() *  900

  allBiomes = [] 

  lastBiome = -> (_ allBiomes).last()

  allBiomes.push
    type: Biome.randomType()
    x: 0
    y: 0
    size: randomSize()

  Biome.insert(lastBiome())

  (_ 10).times ->
    last = lastBiome()

    newSize = randomSize()
    allBiomes.push
      type: Biome.randomType()
      x: Math.floor(last.x + (last.size + newSize) * randomGrowth())
      y: Math.floor(last.y + (last.size + newSize) * randomGrowth())
      size: newSize

    Biome.insert(lastBiome())

Biome.generateItems = ->
  Biome.find().forEach (biome) ->
    (_ 15).times ->
      Biome.randomItemFor(biome)

Biome.placePlayers = ->
