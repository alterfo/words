http = require('http')
querystring = require('querystring')
exec = require('child_process').exec


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
      last_payload = JSON.parse(body)
      exec './deploy.sh', (error, stdout, stderr) ->
        response.writeHead 200, 'Content-Type': 'text/plain'
        response.end if error then stderr else stdout
        return
    return
  return
).listen 4567
console.log 'Server running at http://*:4567/'
