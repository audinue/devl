
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

process.chdir os.homedir()

app.listen 3333
