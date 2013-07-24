class @Layer
  constructor: ->
    (_ this).extend(new createjs.Container())
    @resources = {}

  observations: ->
    added: (id, resource) =>
      resourceView = new @resourceType(resource)
      @resources[id] = resourceView 
      @addChild(resourceView)
      @afterAdded?(id, resourceView)

    changed: (id, resource) =>
      @resources[id]?.changed(resource)

    removed: (id) =>
      @removeChild(@resources[id])
      delete @resources[id]
