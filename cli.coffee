
childProcess = require 'child_process'
path = require 'path'
http = require 'http'
os = require 'os'
opn = require 'opn'

startServer = ->
    childProcess.spawn 'start', [
        '/b',
        path.join __dirname, 'node_modules', '.bin', 'coffee'
        path.join __dirname, 'server.coffee'
    ],
    shell: true
    stdio: 'ignore'

checkServer = (callback) ->
    http.get 'http://127.0.0.1:3333/devl', ->
            callback true
        .on 'error', ->
            callback false

main = (args) ->
    checkServer (started) ->
        if not started
            startServer()
    if not args.length
        return
    url = 'http://127.0.0.1:3333/' + 
        path.relative os.homedir(), args[0]
            .replace /\\/g, '/'
    url += '.devl'
    opn url, app: ['chrome', '--new-window']


main process.argv[2..]
