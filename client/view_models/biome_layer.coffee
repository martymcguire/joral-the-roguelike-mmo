Meteor.startup ->
  class @BiomeLayer extends Layer
    constructor: ->
      @resourceType = BiomeView
      @resourceName = "Biome"
      super()
