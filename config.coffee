trr.config =

  # Currently, 'devMode' is only used for ensuring http protocol locally.
  # This is so a browser on a local area network can sign in on a
  # localhost environment without being pushed to https.
  devMode:                false

  # We need to know if we're live to determine whether or not to notify AdWords
  # and other trackers
  isProduction:           false

  # We use Modernizr to determine whether the browser is traditional or touch.
  isTouchEnabled:         Modernizr.touch



  webServiceURL:          '/api/'
  obsessURL:              '/obsessions/createsocial.json'

  # This is a random mishmash of selectors used around the site. The idea is
  # that we can increase code re-use and reduce "spaghetti-ness" if we can
  # centralize selectors into one file.

  # TODO: Alphabetize!
  el:
    flashNotice:          '.flash.notice'
    saleCountdown:        '#sale_countdown, .sale_countdown'
    hasHidden:            '.has-hidden'
    signInModalForm:      '#sign-in-modal-form'
    signUpModalForm:      '#sign-up-modal-form'
    obsession:            '.obsession'
    accountNameLink:      '#account-name-link'
    clearFilterLink:      '.clear-filter-link'
    sidePanelSearch:      '#sidepanelsearch'
    freeMembershipSigninOverlay:
                          '#free_membership_signin_overlay'
    freeMembershipSignupOverlay:
                          '#free_membership_signup_overlay'
    userURL:              '#user-url'
    viewPerPage:          '#view-per-page'

    todaysSalesItem:      '#main_pulldown .todays-sales-item'
    endingSoonItem:       '#main_pulldown .ending-soon-item'
    upcomingSalesItem:    '#upcoming_pulldown .upcoming-sales-item'
    termsOfServiceLink:   '#terms-of-service-field .terms-of-service-link'
    termsOfServiceDialog: '#big-text-dialog'
    upcomingSalesTitle:   '#upcoming-sales .upcoming_title'


    # related to trr.filters (yet to be implemented in product search)
    checked:              '.checked'
    sidebarFilters:       '.sidebar_filters'
    saleCheckbox:         '.sale-checkbox'
    saleSidebar:          '#sale-sidebar'
    colorCheckbox:        '.color-checkbox'
    clothingSizeCheckbox: '.clothing-size-checkbox'
    shoeSizeCheckbox:     '.shoe-size-checkbox'
    designerCheckbox:     '.designer-checkbox'

    conversionScript:     '#conversion-script'
    totalAmount:          '#total-amount'
    orderNumber:          '#order-number'
    dialogFetchedContent: '.dialog-fetched-content'



    # admin pages
    sendNewsletterButton: '#send-newsletter-button'



  paths:
    getAssetsPath: ->
      'assets' + '/'

    getImagesPath: ->
      trr.config.paths.getAssetsPath() + 'images' + '/'

    getJavascriptsPath: ->
      trr.config.paths.getAssetsPath() + 'javascripts' + '/'

    getStylesheetsPath: ->
      trr.config.paths.getAssetsPath() + 'stylesheets' + '/'


  controls:
    dialog:

      # Dialog types
      base:
        title: ''
        autoOpen: false
        width: 450
        height: 150
        position: 'center'
      email:
        title: 'Email a Friend'
        productDescription: 'Test description'
        productName: 'Test Name'
        template: '#email-dialog-template'
        subjectPrefix: "I'm obsessing about: "
      confirm:
        el: '#confirm-dialog'
        template: '#confirm-dialog-template'
        title: 'Confirm Dialog'
        message: 'Are you sure?'
        width: 450
        height: 150
        affirmativeButtonLabel: 'Yes'
        affirmativeButtonClass: '.affirmative-button'
        negativeButtonLabel: 'No'
        negativeButtonClass: '.negative-button'
      bigText:
        el: '#big-text-dialog'
        template: '#big-text-dialog-template'
        title: ''
        message: ''
        width: 800
        height: 500
        buttonLabel: 'OK'
        buttonClass: '.ok-button'
        urlToFetch: null
        containerID: ''
      alert:
        el: '#alert-dialog'
        template: '#alert-dialog-template'
        title: 'Alert Dialog'
        message: ''
        width: 475
        height: 150
        buttonLabel: 'OK'
        buttonClass: '.ok-button'


      # Specific dialogs
      cancelFirstLookDialog:
        title: 'First Look Membership'
        message: 'Are you sure you want to cancel your First Look membership?'
        cancelLink:  '#cancel-first-look-link'
      orderEmailDialog:
        title: 'Order Confirmation Email'
        message: (emailAddress) -> "A confirmation email has been sent to #{emailAddress}."
        errorMessage: 'Sorry, the order confirmation email could not be sent.'


    countdown:
      saleEndsInXDaysAndXHours: 'Sale ends in {d<}{dn} {dl} and {d>} {hn} {hl}'
      saleEndsInLessThanXHours: 'Sale ends in less than {hn} {hl}'
      saleEndsInLessThan: 'Sale ends in less than '
      hours: ' hours'
      saleEndsInXHours: 'Sale ends in {hn} {hl}'
      saleEndsOnTheHour: 'Sale ends at the end of this hour'
      saleHasEnded: 'Sale has ended'


  messages:
    loggedInSuccessfully: 'Logged in successfully'
    adminSendNewsletter: 'Are you sure you want to send this newsletter?'
    adminSendNewsletterTitle: 'Confirm Sending Newsletter'





