path = require 'path'
fs = require 'fs'
chalk = require 'chalk'
exec = require('child_process').exec
execSync = require('child_process').execSync
log = console.log

MULBERRY_VERSION = '0.0.0'

shouldUseYarn = () ->
  try
    execSync 'yarnpkg --version', stdio: 'ignore'
    true
  catch e
    false
shouldUseNpm = () ->
  try
    execSync 'npm --verison', stdio: 'ignore'
    true
  catch e
    false

install = (pkg, version) ->
  if shouldUseYarn
    execSync "yarn add --exact #{pkg}@#{version}"
  else if shouldUseNpm
    execSync "npm install --save "

createProject = (name) ->
  # Get the path
  root = path.resolve name
  log "Creating a new Mulberry project in #{chalk.green(root)}"

  # Create the directory structure
  fs.mkdirSync root
  process.chdir root
  dirs = ['src', 'src/server', 'src/client', 'src/client/jumbotron', 'src/client/mobile']
  fs.mkdirSync dir for dir in dirs

  # Create a default package.json
  packageJson =
    name: name
    version: '0.1.0'
  fs.writeFileSync 'package.json',
    JSON.stringify packageJson, null, 2

  # Add the installed version of Mulberry as a dependency
  install 'mulberry', MULBERRY_VERSION

if process.argv[2] == 'init'
  createProject process.argv[3]
else
  exec 'redis-server'
  log chalk.green 'Redis server running...'
