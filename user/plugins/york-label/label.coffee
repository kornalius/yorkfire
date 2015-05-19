{ hazel, BaseView, Class, Plugin, expose, unexpose, theme, renderable, div, span } = York
{ important, none, auto, inherit, absolute, baseline, relative, transparent, rgba, em, rem } = York.css

York.LabelView = Class 'LabelView',
  extends: BaseView

  layout:

    attributes: ['icon', 'tag', 'color']

    style: ->

      ':host':
        display: 'inline-block';
        verticalAlign: baseline
        lineHeight: 1
        margin: theme.margin.small
        backgroundColor: transparent
        border: none
        backgroundImage: none
        padding: 0
        textTransform: none
        boxSizing: 'border-box'
        WebkitTransition: 'background .2s ease'
        transition: 'background .2s ease'
        color: theme[if @color? then @color else 'white'].text

      ':host([icon]:first-child)':
        marginLeft: em 0

      ':host([icon]:last-child)':
        marginRight: em 0

      'a':
        cursor: 'pointer'
        color: inherit
        opacity: .8
        WebkitTransition: '0.2s opacity ease'
        transition: '0.2s opacity ease'

      'a:hover':
        opacity: 1

      'icon-view':
        width: auto
        margin: em 0, .75, 0, 0

      ':host([tag])':
        borderRadius: rem .2
        padding: theme.padding.small
        backgroundColor: theme[if @color? then @color else 'grey'].color
        color: theme[if @color? then @color else 'black'].text

      ':host([tag]):hover':
        opacity: .5

      # ':host(:focus)':
      #   opacity: 1

      # ':host(:active)':
      #   opacity: 1

      ':host(:disabled)':
        pointerEvents: none
        opacity: important .3


    template: renderable (el, content) ->
      if _.isString el.icon
        icon_view el.icon
      span el.textContent


module.exports =

  load: ->
    hazel 'label-view', York.LabelView

  unload: ->
