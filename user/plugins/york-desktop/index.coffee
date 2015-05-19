{ hazel, Class, Plugin, ccss, expose, unexpose, $, path, loadCSS } = York

require('./desktop.coffee')
require('./task-panel.coffee')

module.exports =

  load: ->
    loadCSS(path.join(__dirname, 'main.css'))

    hazel 'task-panel-view', York.TaskPanelView
    hazel 'desktop-view', York.DesktopView

    York.appendElement 'desktop-view', 'body'

  unload: ->
    $(':root /deep/ desktop-view').each (el) ->
      if el.parentNode?
        el.parentNode.removeChild(el)
