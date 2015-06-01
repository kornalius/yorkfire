{ hazel, BaseView, Class, Plugin, expose, unexpose, renderable, div } = York

York.TaskPanelView = Class 'TaskPanelView',
  extends: BaseView

  layout:

    attributes: ['align']

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
