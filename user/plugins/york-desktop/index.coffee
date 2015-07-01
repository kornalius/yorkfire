{ hazel, Class, Plugin, ccss, expose, unexpose, $, path, loadCSS } = York

require('./desktop.coffee')

module.exports =

  load: ->
    loadCSS(path.join(__dirname, 'main.css'))

    hazel 'desktop-view', York.DesktopView

    York.appendElement 'desktop-view', 'body'

  unload: ->
    $(':root /deep/ desktop-view').each (el) ->
      if el.parentNode?
        el.parentNode.removeChild(el)
