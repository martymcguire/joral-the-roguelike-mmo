Meteor.methods
  regenerate: ->
    Biome.resetBiosphere()

  checkin: (id) ->
    Player.update id, { $set: { lastCheckin: +(new Date()) } }