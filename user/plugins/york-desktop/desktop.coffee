TaskPanel = require('./task-panel.coffee')

{ BaseView, Class, Plugin, expose, unexpose } = York

York.DesktopView = Class 'DesktopView',
  extends: BaseView
  with: [York.SelectBehavior]

  layout:

    attributes: ['color']


    template: ->


  '@click': (e) ->
    console.log 'clicked', e
