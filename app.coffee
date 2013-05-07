$(document).ready ->
  trr.app.ready()

$(window).load ->
  trr.app.load()

(->
  trr.app =
    ready: ->
      @execute('trr.common')

    load: ->

    # Execute a namespaced block of code
    execute: (namespace) ->
      #console.info('executing namespace: ', namespace)
      names = namespace.split('.')
      if names[2]
        window[ names[0] ][ names[1] ][ names[2] ].ready()
      else
        window[ names[0] ][ names[1] ].ready()

)()