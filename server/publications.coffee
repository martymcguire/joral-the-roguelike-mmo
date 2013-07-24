Meteor.publish "players", ->
  Player.find({ active: true })
Meteor.publish "currentPlayer", (id) ->
  Player.find( {_id: id} )

Meteor.publish "biomes", -> Biome.find({})
Meteor.publish "items", -> Item.find({})
Meteor.publish "notifications", -> Item.find({})