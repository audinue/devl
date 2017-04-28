
express  = require 'express'

files = {}

serveSourceMap = (req, res, next) ->
    if files.hasOwnProperty req.url
        res.type 'map'
        res.send files[req.url]
    else
        next()

sourceMapServer = express.Router()
sourceMapServer.files = files
module.exports = sourceMapServer
    .get '*.map', serveSourceMap
