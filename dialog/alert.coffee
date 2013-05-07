alert = trr.config.controls.dialog.alert

$.widget 'trr.alertDialog', trr.baseDialog, {

  options: {
    message: alert.message
    buttonLabel: alert.buttonLabel
    buttonClass: alert.buttonClass
  }

  _init: ->
    # Create dialog, bind buttons, open dialog
    @._generateDialog()._bindButton().open()
    @

  _generateDialog: ->
    #console.warn 'alertDialog::_generateDialog'
    self = @
    source = $(alert.template).html()
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
    $(self.options.buttonClass).on 'click', ->
      self.close();
    @



}


