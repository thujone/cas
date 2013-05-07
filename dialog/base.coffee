base = trr.config.controls.dialog.base

$.widget 'trr.baseDialog', $.ui.dialog, {

options: {
  title:         base.title
  autoOpen:      base.autoOpen
  width:         base.width
  height:        base.height
  position:      base.position
  closeOnEscape: true
  modal:         false
  hide: {
    effect:      'fadeOut'
    duration:    300
  }
  show: {
    effect:      'fadeIn'
    duration:    300
  }
}

_create: ->
  $.ui.dialog.prototype._create.call @
  @

_init: ->
  @

_generateDialog: ->
  @


}


