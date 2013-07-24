class @Hexordinate
  parityChart: 
    0: [1, -1]
    1: [2, 0]
    2: [1, 1]
    3: [-1, 1]
    4: [-2, 0]
    5: [-1, -1]

  constructor: (array) ->
    @array = Hexordinate.validate(array)

  toString: -> "Hexordinate[#{@array.join()}]"
  isOrigin: -> @array.length is 0

  add: (hexordinate) ->
    array = @array.concat hexordinate.array
    new Hexordinate(array)

  addRandom: (distance = 1) ->
    step = Math.floor(Math.random()*6)
    directionVector = new Hexordinate [ step ]
    @add( directionVector )

  subtract: (hexordinate) ->
    array = @array.concat hexordinate.invert().array
    new Hexordinate(array)

  invert: () ->
    invertIndex = (index) ->
      switch index
        when 0 then 3
        when 1 then 4
        when 2 then 5
        when 3 then 0
        when 4 then 1
        when 5 then 2
    invertedArray = (invertIndex(index) for index in @array)
    new Hexordinate(invertedArray)

  getAdjacencies: () ->
    [
      new Hexordinate(@array.concat(0)),
      new Hexordinate(@array.concat(1)),
      new Hexordinate(@array.concat(2)),
      new Hexordinate(@array.concat(3)),
      new Hexordinate(@array.concat(4)),
      new Hexordinate(@array.concat(5))
    ]

  getGroupAdjacencies: () ->
    [
      new Hexordinate(@array.concat([0, 0, 1])),
      new Hexordinate(@array.concat([1, 1, 2])),
      new Hexordinate(@array.concat([2, 2, 3])),
      new Hexordinate(@array.concat([3, 3, 4])),
      new Hexordinate(@array.concat([4, 4, 5])),
      new Hexordinate(@array.concat([5, 5, 0]))
    ]

  applyParityTo: (coordinate) ->
    transformedX = coordinate[0]
    transformedY = coordinate[1]

    for hexordinate in @array
      do (hexordinate) =>
        parity = @parityChart[hexordinate]
        throw "What neighbor is this? #{direction}" unless parity?

        transformedX += parity[0]
        transformedY += parity[1]

    [transformedX, transformedY]
    
Hexordinate.validate = (array) ->
  array = array.array or array
  coordinates = [0..5]

  isValidCoordinate = (el) ->
    throw "Invalid index: #{el}" unless coordinates.indexOf(el) > -1

  array.every(isValidCoordinate)

  # [ [0, 0], [1, 1, 1], [2], [3, 3], ...]
  groups = coordinates.map (coordinate) ->
    array.filter (el) -> el is coordinate

  counts = groups.map (group) -> group.length

  truncateToMin = (groupsToReduce, groupToAdd=null) ->
    numToTransfer = Math.min.apply(null, (counts[group] for group in groupsToReduce))    

    counts[group] -= numToTransfer for group in groupsToReduce
    counts[groupToAdd] += numToTransfer if groupToAdd?

  # this is my primary assumption about hex charting
  truncateToMin([0, 2, 4])
  truncateToMin([1, 3, 5])
  truncateToMin([0, 3])
  truncateToMin([1, 4])
  truncateToMin([2, 5])

  truncateToMin([0, 2], 1)
  truncateToMin([1, 3], 2)
  truncateToMin([2, 4], 3)
  truncateToMin([3, 5], 4)
  truncateToMin([4, 0], 5)
  truncateToMin([5, 1], 0)

  answer = []
  for count, coordinate in counts
    answer.push(coordinate) while (count -= 1) >= 0

  answer

