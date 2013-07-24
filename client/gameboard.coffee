Template.gameboard.events =
  'click': (event) ->
    worldCoords = camera.translate(event)
    player = Player.findOne(amplify.store('playerId'))

    if player?
      Player.update(player._id, { $set: { x: worldCoords.x, y: worldCoords.y } })

Template.gameboard.canvasWidth  = "800px" # -> Session.get 'canvas.width'
Template.gameboard.canvasHeight = "600px" # -> Session.get 'canvas.height'