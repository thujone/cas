(->
  trr.common =

    ready: ->
      @determineDevMode()
      @determineIsProduction()
      @suppressLoggedInMessage()
      @preserveLocalProtocol()
      @displayAccountName()
      @setPopupPositions()
      @limitDropdownLists()
      @enableCommonPopups()
      @addEllipses()

    # Set devMode config value to true if ".local" or "localhost" is part of the url
    determineDevMode: ->
      if /(\.local|localhost)/.test(location.hostname)
        trr.config.devMode = true
      else trr.config.devMode = false

    # We need to know whether or not to notify pixel trackers and google adwords
    determineIsProduction: ->
      if /(www\.therealreal\.com)/.test(location.hostname)
        trr.config.isProduction = true
      else trr.config.isProduction = false

    suppressLoggedInMessage: ->
      flashNotice = $(trr.config.el.flashNotice)
      if flashNotice.html() == trr.config.messages.loggedInSuccessfully
        flashNotice.css {visibility: 'hidden'}

    # Keeps the signin form protocol 'http' if we are accessing the site on a local network
    # i.e., if we're using a Windows or iOS device to access a local dev host
    preserveLocalProtocol: ->
      if trr.config.devMode
        form = $(trr.config.el.signInModalForm).find('form:first')
        if form.length > 0
          action = form.attr 'action'
          action = action.replace /https:/, 'http:'
          form.attr 'action', action


    # Attempt to control spacing in the header area dynamically so the account name
    # doesn't look bad.
    displayAccountName: ->
      accountNameLink = $(trr.config.el.accountNameLink)
      if accountNameLink.width() < 20
        accountNameLink.css {
          paddingRight: '20px'
        }
      else if accountNameLink.width() < 30
        accountNameLink.css {
          paddingRight: '10px'
        }

    setPopupPositions: ->
      trr.util.centerPopup trr.config.el.freeMembershipSignup
      trr.util.setOverlayHeight trr.config.el.loginContainer


    limitDropdownLists: ->

      todaysSales = $(trr.config.el.todaysSalesItem)
      todaysSales.filter(':gt(9)').hide()
      $('#more-current-sales').show() if todaysSales.length > 9

      endingSales = $(trr.config.el.endingSoonItem)
      endingSales.filter(':gt(9)').hide()
      $('#more-ending-sales').show() if endingSales.length > 9

      @

    enableCommonPopups: ->
      $(trr.config.el.termsOfServiceLink).on 'click', ->
        termsOfServiceDialog = $(trr.config.el.termsOfServiceDialog)
        termsOfServiceDialog.bigTextDialog({
          message: ''
          urlToFetch: '/site/terms.mobile'
        })
        termsOfServiceDialog.bigTextDialog 'open'

    addEllipses: ->
      $(trr.config.el.upcomingSalesTitle).each ->
        $(this).dotdotdot
          ellipsis : '...'

)()
