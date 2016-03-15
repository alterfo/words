http = require('http')
querystring = require('querystring')
exec = require('child_process').exec


#process.on 'uncaughtException', (error) ->
#  console.error 'Uncaught exception: ' + error.message
#  console.trace()


last_payload = {}

http.createServer((request, response) ->
  if request.method == 'GET'
    response.writeHead 200, 'Content-Type': 'text/html'
    response.write '<html><body><pre>'
    response.write JSON.stringify(last_payload, null, '\\u9')
    response.write '</pre></body></html>'
    response.end()
  else
    body = ''
    request.on 'data', (chunk) ->
      body += chunk.toString()
      return
    request.on 'end', ->
      console.log 'request end', querystring.parse(body)
      if body
        last_payload = JSON.parse(querystring.parse(body).payload) || {}
        console.log new Date, request.method, request.url, last_payload
        exec './deploy.sh', (error, stdout, stderr) ->
          response.writeHead 200, 'Content-Type': 'text/plain'
          response.end if error then stderr else stdout
          return
      return
  return
).listen 4567
console.log 'Server running at http://*:4567/'
