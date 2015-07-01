{ hazel, BaseView, Class, Plugin, css, expose, unexpose, renderable, component, div, span } = York
{ block, absolute  } = css

York.DesktopView = Class 'DesktopView',
  extends: BaseView

  layout:

    attributes: ['color']

    style: ->

    template: renderable ->
      windowView()


  created: ->
    @super()

