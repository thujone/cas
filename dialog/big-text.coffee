# Use this for overlays containing a lot of text, such as ToS

bigText = trr.config.controls.dialog.bigText

$.widget 'trr.bigTextDialog', trr.baseDialog, {


options: {
  message: bigText.message
  urlToFetch: bigText.urlToFetch
  buttonLabel: bigText.buttonLabel
  buttonClass: bigText.buttonClass
  closeText: 'x'
  modal: true
}

_init: ->
  @._generateDialog()
  @._fetchURL()
  @._bindButton()
  @.open()
  @

_fetchURL: ->
  self = @
  if self.options.urlToFetch
    $(trr.config.el.dialogFetchedContent).load(self.options.urlToFetch)

_generateDialog: ->
  self = @
  source = $(bigText.template).html()
  template = Handlebars.compile source
  context = {
    title: self.options.title
    message: self.options.message
    button_label: self.options.buttonLabel
    button_class: self.options.buttonClass.slice(1)
  }
  html = template context
  $(this.element).html html
  @

_bindButton: ->
  self = @
  $(self.options.buttonClass).click ->
    self.close()
  @
}


