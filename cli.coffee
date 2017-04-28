
childProcess = require 'child_process'
path = require 'path'
http = require 'http'
os = require 'os'
opn = require 'opn'

spawn = (command, args...) ->
    childProcess.spawn command, args,
            detached: true
            stdio: 'ignore'
            shell: true
        .unref()

startServer = ->
    spawn path.join(__dirname, 'node_modules', '.bin', 'coffee'), [path.join __dirname, 'server.coffee']

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
