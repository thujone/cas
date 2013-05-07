# Set global ajax config for the customer app.
# Don't change the Spree admin app jquery settings!
if trr.admin is not {}
  $.ajaxSetup
    cache:    false
    global:   true
    type:     'POST'
    url:      trr.config.webServiceURL
    dataType: 'json'

(->
  trr.ajax =
    getAjaxSuccess: (caller, response, callback) ->
      #console.info 'ajax success!', 'caller:', caller, 'response:', response
      if callback
        callback response
      else
        #console.warn 'no callback defined for ' + caller

    getAjaxError: (caller, request, message, failureCallback) ->
      #console.info 'ajax failure!', 'caller:', caller, 'request:', request, 'message:', message
      if failureCallback
        failureCallback caller, request, message
      else
        @showDefaultAjaxError caller, request, message

    showDefaultAjaxError: (caller, request, message) ->
      try
        #console.error 'showDefaultAjaxError:', caller, request, message
      catch error
        #console.error 'caught ajax error:', error

    generateURL: (args) ->
      url = trr.config.webServiceURL

      # If just a string (i.e., single argument), convert to an array for processing below
      args = [args]  if _.isString(args)
      if _.isArray(args)
        _.each args, (arg) ->
          url += '/' + arg
      else
        #console.error 'error generating a RESTful url'
      url


    calls:

      ###
      getSomething: (callback, failureCallback) ->
        caller = "getSomething"
        args = trr.ajax.messageTypes.getSomething
        trr.app.displayURL trr.ajax.generateURL(args), trr.ajax.messageTypes.getClientID
        $.ajax
          url: trr.ajax.generateURL(args)
          success: (response) ->
            trr.ajax.getAjaxSuccess caller, response, callback

          error: (request, message) ->
            trr.ajax.getAjaxError caller, request, message, failureCallback
      ###

      sendSocialEmail: (args, callback, failureCallback) ->
        caller = 'sendSocialEmail'
        $.ajax
          data: {
            to:         args.to
            subject:    args.subject
            user_notes: args.userNotes
            share_id:   args.shareID
            share_type: args.shareType
            session_id: args.sessionID
          }
          url: trr.config.webServiceURL + trr.ajax.calls[caller]
          success: (response) ->
            trr.ajax.getAjaxSuccess caller, response, callback
          error: (request, message) ->
            trr.ajax.getAjaxError caller, request, message, failureCallback

      # Refresh the list of sale or search items
      updateSaleItems: (args, callback, failureCallback) ->
        caller = 'updateSaleItems'
        $.ajax
          data: {
            to: args
          }
          url: trr.config.webServiceURL + trr.ajax.calls[caller]
          success: (response) ->
            trr.ajax.getAjaxSuccess caller, response, callback
          error: (request, message) ->
            trr.ajax.getAjaxError caller, request, message, failureCallback

      # Obsess product or variant
      obsess: (args, callback, failureCallback) ->
        caller = 'obsess'
        $.ajax
          dataType: 'text'
          data:
            flash_sale_id: args.flash_sale_id
            variant_id:    args.variant_id
          url: trr.config.webServiceURL + trr.ajax.calls[caller]
          success: (response) ->
            trr.ajax.getAjaxSuccess caller, response, callback
          error: (request, message) ->
            trr.ajax.getAjaxError caller, request, message, failureCallback


)()
