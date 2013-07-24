class @PlayerLayer extends Layer
  constructor: ->
    @resourceType = PlayerView
    @resourceName = 'Player'
    super()

  afterAdded: (id, view) ->
    if id == amplify.store('playerId')
      view.addObserver camera

