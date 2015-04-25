{ hazel, Plugin, expose, unexpose, renderable, div } = York

hazel 'base-view',

  style: ->
    ':host':
      position: 'relative'
      display: 'inline-block'
      cursor: 'default'

  template: renderable (el, content) ->
    div ->
      if content?
        content(el)

