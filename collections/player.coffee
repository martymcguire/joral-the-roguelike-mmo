@Player = new Meteor.Collection("players")

Player.retrieveFromStore = (callback) ->
  playerId = amplify.store('playerId')

  console.log "Subscribing to player: #{playerId}"

  Meteor.subscribe 'currentPlayer', playerId, ->
    player = Player.findOne(playerId)

    unless player?
      name = prompt("What is your name?")
      playerId = Player.insert(name: name, x: 0, y: 0, active: true)
      amplify.store('playerId', playerId)
      player = Player.findOne(playerId)

    Player.update(playerId, { $set: { active: true } })

    Session.set 'player', player
  
    callback(player)