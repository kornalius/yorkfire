{ hazel, Plugin, expose, unexpose, renderable, div } = York

hazel 'task-panel-view',
  extends: 'base-view'

  style: ->
    ':host':
      display: 'block'
      position: 'absolute'
      color: 'black'
      width: if @align in ['top', 'bottom'] then '100%' else '75px'
      height: if @align in ['left', 'right'] then '100%' else '75px'
      backgroundColor: '#E6E6E6'

  template: renderable (el, content) ->
    div ->

  created: ->
    @align = 'bottom'
    @super()


module.exports =

  load: ->

  unload: ->
    $(':root /deep/ task-panel').each (el) ->
      if el.parentNode?
        el.parentNode.removeChild(el)
