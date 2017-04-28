
os              = require 'os'
path            = require 'path'
express         = require 'express'
rollup          = require 'rollup'
nodeResolve     = require 'rollup-plugin-node-resolve'
coffeeScript    = require 'rollup-plugin-coffee-script'
sourceMapServer = require './source-map-server'

bundleCache = null

serveCoffee = (req, res) ->
    entry = req.url.substring 1
        .replace /\.js$/, ''
    options =
        entry: entry
        plugins: [
            nodeResolve extensions: [
                '.js'
                '.coffee'
            ]
            coffeeScript()
        ]
        moduleName: 'bundle'
        format: 'iife'
        sourceMap: true
        sourceMapFile: entry
        cache: bundleCache
    rollup.rollup options
        .then (bundle) ->
            bundleCache = bundle
            sourceMapURL = req.url + '.map'
            result = bundle.generate options
            sourceMapServer.files[sourceMapURL] = result.map
            res.type 'js'
            res.send result.code + '//# sourceMappingURL=' + sourceMapURL
        .catch (error) ->
            res.send "throw new Error(#{JSON.stringify error.message})"

module.exports = express.Router()
    .get '*.coffee.js', serveCoffee
