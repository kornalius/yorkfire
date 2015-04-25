TaskPanel = require('./task-panel.coffee')

{ hazel, Plugin, expose, unexpose, renderable, div, span } = York

hazel 'desktop-view',
  extends: 'base-view'

  attributes: 'color'

  style: ->
    ':host':
      display: 'block'
      position: 'absolute'
      color: 'white'
      width: '100%'
      height: '100%'
      backgroundColor: if @color? then @color else 'black'
    '#text':
      display: 'inline-block'
      margin: '16px'

  template: renderable (el, content) ->
    div ->
      span '#text', "DESKTOP"
      span '#text', "DESKTOP"

  created: ->
    @super()
    @panels = []

  addPanel: (align) ->
    return document.createElement('task-panel-view')


module.exports =

  load: ->
    York.appendElement 'desktop-view', 'body',
      color: 'silver'

  unload: ->
    $(':root /deep/ desktop-view').each (el) ->
      if el.parentNode?
        el.parentNode.removeChild(el)
