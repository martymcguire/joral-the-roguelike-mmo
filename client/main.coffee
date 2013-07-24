
Meteor.startup () ->
  Session.set("camera.zoom", 7)

  stage = new Stage()

  worldContainer = new createjs.Container()
  stage.addChild(worldContainer)

  biomeLayer = new BiomeLayer()
  worldContainer.addChild(biomeLayer)

  itemLayer = new ItemLayer()
  worldContainer.addChild(itemLayer)

  playerLayer = new PlayerLayer()
  worldContainer.addChild(playerLayer)

  @camera = new Camera(worldContainer)

  player = Player.retrieveFromStore (player) ->
    camera.lookAt player

    Meteor.setInterval ->
      Meteor.call('checkin', player._id)
    , 5000

  Meteor.subscribe "players", ->
    query = Player.find({})
    handle = query.observeChanges playerLayer.observations()

  Meteor.subscribe "biomes", ->
    query = Biome.find({})
    handle = query.observeChanges biomeLayer.observations()
    # .forEach (biome) -> drawBiome(biomeLayer, biome)

  Meteor.subscribe "items", ->
    query = Item.find({})
    handle = query.observeChanges itemLayer.observations()

  Meteor.subscribe "notificaitons", ->
    query = Notificaiton.find({})
