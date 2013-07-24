Session.set 'debug.mode', off

Template.debug.events =
  'click #regenerate': ->
    if prompt 'Really annihilate the world and rebirth it?'
      Meteor.call('regenerate')

  'click #camera-toggle': ->
    Camera.toggleMode()

  'change #camera-target': (event) ->
    pickedBiomeId = ($ event.currentTarget)[0].value
    biome = Biome.findOne _id: pickedBiomeId
    camera.lookAt biome

  'click .debug-reveal': (event) ->
    Session.set 'debug.mode', on

  'click #increment-width': (event) -> Session.set('game.width', Session.get('game.width') + 100)
  'click #decrement-width': (event) -> Session.set('game.width', Session.get('game.width') - 100)
  'click #increment-height': (event) -> Session.set('game.height', Session.get('game.height') + 100)
  'click #decrement-height': (event) -> Session.set('game.height', Session.get('game.height') - 100)
  'click #increment-zoom': (event) -> Session.set('camera.zoom', Session.get('camera.zoom')* 2)
  'click #decrement-zoom': (event) -> Session.set('camera.zoom', Session.get('camera.zoom')* .5)

Template.debug.activeDuringDebug = -> Session.get('debug.mode') or 'active'
Template.debug.activeDuringDebug = -> Session.get('debug.mode') and 'active'
Template.debug.debugMode = -> Session.get 'debug.mode'
Template.debug.cameraMode = -> Session.get 'camera.mode'
Template.debug.biomes = -> Biome.find()
Template.debug.players = -> Player.find()
Template.debug.player = ->
  player = Player.findOne amplify.store('playerId')

  if player?
    (_ player).extend x: Math.floor(player.x), y: Math.floor(player.y)