Meteor.setInterval ->
  growRandomTrees()
, 1000

Meteor.setInterval ->
  deactivateIdlePlayers()
, 5000

growRandomTrees = ->
  totalItems = Item.find({ type: 'tree' }).count()
  ids = Item.find({ type: 'tree' }, { skip: Math.random()*totalItems, limit: 5 }).map (item) -> item._id
  Item.update({ _id: { $in: ids } }, {$inc: { age: 1 }}, multi: true)
  Item.update({ age: { $gt: 8 } }, { $set: { age: 0 }}, multi: true)

deactivateIdlePlayers = ->
  Player.update { lastCheckin: { $lt: +(new Date()) - 10000 } }, { active: { $set: false } }