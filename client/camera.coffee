class @Camera
  defaults:
    zoomLevel: 7

  constructor: (@targetContainer) ->
    (() =>
      instaZoom = off
      Deps.autorun =>
        zoomLevel = Session.get('camera.zoom') || @defaults.zoomLevel
        @zoomTo(zoomLevel, instaZoom)
  
      instaZoom = on
    )()

  zoomTo: (targetZoom, smooth = true) ->
    if smooth
      createjs.Tween.get(@targetContainer, {}, {}, true)
        .to
          scaleX: targetZoom
          scaleY: targetZoom
        , 1600
        , createjs.Ease.quintOut
    else
      @targetContainer.scaleX = targetZoom
      @targetContainer.scaleY = targetZoom

  lookAt: (target, smooth = true) ->
    if smooth
      createjs.Tween.get(@targetContainer, {}, {}, true)
        .to
          regX: target.x
          regY: target.y
        , 600
        , createjs.Ease.quintOut
    else
      @targetContainer.regX = target.x
      @targetContainer.regY = target.y

  translate: (coords) -> @targetContainer.globalToLocal(coords.x, coords.y)

  notify: (observed) -> @lookAt(observed, false)

Camera.toggleMode = ->
    Session.set 'camera.mode',
      switch Session.get('camera.mode')
        when 'tactical' then 'overview'
        when 'overview' then 'tactical'
        else 'overview'