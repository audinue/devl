
os              = require 'os'
express         = require 'express'
coffeeServer    = require './coffee-server'
sourceMapServer = require './source-map-server'
devlServer      = require './devl-server'

app = express()

app.use express.static '.'
app.use coffeeServer
app.use sourceMapServer
app.use devlServer

app.get '/devl', (req, res) ->
    res.send 'OK'

port = 3333
root = os.homedir()

process.chdir root

app.listen port

console.log "Server started on #{port}."
console.log "The root path is #{root}."
