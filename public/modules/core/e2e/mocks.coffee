module.exports = httpBackendMock = ->
  angular.module('httpBackendMock', [
    'ngMockE2E'
    'myApp'
  ]).run ($httpBackend) ->
    authenticated = false
    testAccount = email: 'test@example.com'
    $httpBackend.whenGET('/api/auth').respond (method, url, data, headers) ->
      if authenticated then [
        200
        testAccount
        {}
      ] else [
        401
        {}
        {}
      ]
    $httpBackend.whenPOST('/api/auth').respond (method, url, data, headers) ->
      authenticated = true
      [
        200
        testAccount
        {}
      ]
    $httpBackend.whenDELETE('/api/auth').respond (method, url, data, headers) ->
      authenticated = false
      [
        204
        {}
        {}
      ]
    $httpBackend.whenGET(/.*/).passThrough()
    return
  return
