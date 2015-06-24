{ BaseView, Class, Plugin, expose, unexpose } = York

York.TaskPanelView = Class 'TaskPanelView',
  extends: BaseView

  layout:

    attributes: ['align']


    template: ->


  created: ->
    @align = 'bottom'
    @super()
