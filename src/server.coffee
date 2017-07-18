_ = require 'lodash'
redis = require 'redis'
client = redis.createClient()

generateRoomCode = () ->
  nums = (_.random 25 for [0...4])
  code = nums.map (n) -> String.fromCharCode(65 + n)
  _.join code, ''

createRoom = (gamemode) ->
  # Makes a new room, and adds it to the existing list of rooms
  # Returns a unique identitfier for the room
  
  code = generateRoomCode() while code == undefined or client.exists(code) == 1
  gamemode(room)
  client.del(room)
  
module.exports =
  generateRoomCode: generateRoomCode
  createRoom: createRoom
