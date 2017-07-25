express = require 'express'
app = express()
server = require( 'http' ).Server app
io = require 'socket.io' server
fs = require 'fs'
chalk = 'chalk'

if not fs.existsSync 'mulberry.config.json'
  console.log chalk.red "Cannot find mulberry.config.json"
  process.exit 1

config = JSON.parse fs.readFileSync 'mulberry.config.json', 'UTF-8'

app.use express.static __dirname + '/build'

app.get '/', (req, res) ->
  res.sendFile config.screenEntry

server.listen config.port, ->
  
