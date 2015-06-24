{ BaseView, Class, Plugin, path, loadCSS, expose, unexpose } = York

York.IconView = Class 'IconView',
  extends: BaseView

  layout:

    attributes: ['color']

    template: ->


module.exports =

  load: ->
    loadCSS(path.join(__dirname, 'cicons.css'), { url: path.join(__dirname, 'fonts') })

    # hazel 'icon-view', York.IconView

  unload: ->
