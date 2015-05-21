{ hazel, BaseView, Class, Plugin, expose, unexpose, theme, renderable, div, span } = York
{ important, none, baseline, inherit, normal, center, transparent, rgba, em, rem } = York.css

York.ButtonView = Class 'ButtonView',
  extends: BaseView

  layout:

    attributes: ['icon', 'small', 'large', 'color', 'on-click']

    style: ->

      ':host':
        cursor: 'default'
        display: 'inline-block'
        minHeight: em 1
        outline: none
        borderRadius: rem .3
        border: if @color? and @color.startsWith('transparent') then "2px solid #{theme[@color].text}" else none
        verticalAlign: baseline
        margin: em 0, .25, 0, 0
        padding: em .79, 1.5, .79
        textTransform: none
        textShadow: none
        fontWeight: normal
        lineHeight: 1
        fontStyle: normal
        textAlign: center
        textDecoration: none
        backgroundImage: none
        WebkitUserSelect: none
        userSelect: none
        WebkitTransition: 'opacity .1s ease, background-color .1s ease, color .1s ease, box-shadow .1s ease, background .1s ease'
        transition: 'opacity .1s ease, background-color .1s ease, color .1s ease, box-shadow .1s ease, background .1s ease'
        willChange: none
        WebkitTapHighlightColor: transparent
        boxShadow: '0px 0px 0px 1px transparent inset, 0px 0em 0px 0px rgba(39, 41, 43, .15) inset'
        backgroundColor: theme[if @color? then @color else 'grey'].color
        color: theme[if @color? then @color else 'white'].text

      ':host(:hover)':
        backgroundColor: theme[if @color? then @color else 'grey'].dark
        backgroundImage: none
        boxShadow: none

      ':host(:hover).icon':
        opacity: .85

      ':host(:focus)':
        backgroundColor: none
        color: rgba(0, 0, 0, .8)
        backgroundImage: important none
        boxShadow: important '0px 0px 0px 1px transparent inset, 0px 0px 1px rgba(81, 167, 232, .8) inset, 0px 0px 3px 2px rgba(81, 167, 232, .8)'

      ':host(:focus) .icon':
        opacity: .85

      ':host(:active), :host(.active), :host([active])':
        backgroundColor: '#cccccc'
        backgroundImage: none
        color: rgba(0, 0, 0, .8)
        boxShadow: important '0px 0px 0px 1px transparent inset, 0px 1px 4px 0px rgba(39, 41, 43, .15) inset'

      ':host(:active:hover), :host(.active:hover), :host([active]):hover':
        backgroundColor: '#d0d0d0'
        backgroundImage: none
        color: rgba(0, 0, 0, .8)

      ':host(:disabled), :host(.disabled), :host([disabled])':
        cursor: 'default'
        backgroundColor: important '#dcddde'
        color: important rgba(0, 0, 0, .4)
        opacity: important .3
        backgroundImage: important none
        boxShadow: important none
        pointerEvents: none

      ':host([small])':
        padding: em(.25, 1, .25)

      ':host([large])':
        padding: em(1.5, 1.5, 1.5)

      'label-view':
        color: inherit

    template: renderable (el, content) ->
      if _.isString el.icon
        icon_view icon: el.icon
      text_view el.textContent


module.exports =

  load: ->
    hazel 'button-view', York.ButtonView

  unload: ->
