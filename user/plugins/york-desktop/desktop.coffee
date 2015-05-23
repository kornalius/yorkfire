TaskPanel = require('./task-panel.coffee')

{ hazel, BaseView, Class, Plugin, css, expose, unexpose, renderable, theme, div, span } = York
{ block, absolute  } = css

York.DesktopView = Class 'DesktopView',
  extends: BaseView
  with: [York.SelectBehavior]

  layout:

    attributes: ['color']

    style: ->
      ':host':
        display: block
        position: absolute
        width: '100%'
        maxWidth: '100%'
        minHeight: '100%'
        backgroundColor: theme[if @color? then @color else 'white'].color
        color: theme[if @color? then @color else 'black'].text
        padding: theme.padding.small

      # '#text':
        # display: 'inline-block'
        # margin: '16px'


    template: renderable (el) ->
      div ->
        text_view '#text', tag: true, color: 'purple', attach: 'bottom',  'DESKTOP 1'
        text_view '#text', 'DESKTOP 2'
        text_view '#text', bordered: 'black', 'DESKTOP 3'
        icon_view color: 'blue', circular: true, 'picture'
        checkbox_view '#checkbox', 'Check this box'
        text_view '#input_test', type: 'input', 'Text content to be edited'


  '@click': (e) ->
    console.log 'clicked', e


  created: ->
    @super()
    @panels = []


  addPanel: (align) ->
    return document.createElement('task-panel-view')
