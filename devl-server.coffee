
express  = require 'express'
path  = require 'path'

serveDevl = (req, res) ->
    src = req.url.replace /\.devl$/, ''
    title = path.basename src
    src += '.js'
    res.type 'html'
    res.send """
        <!DOCTYPE html>
        <html>
            <head>
                <title>#{title}</title>
            </head>
            <body>
                <script src="#{src}"></script>
            </body>
        </html>
    """

module.exports = express.Router()
    .get '*.devl', serveDevl