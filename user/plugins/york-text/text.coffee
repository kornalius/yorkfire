{ Text, t, hazel, BaseView, Class, Plugin, expose, unexpose, theme, renderable, div, span } = York
{ important, none, auto, inherit, absolute, baseline, relative, left, solid, transparent, rgba, em, rem } = York.css


York.TextView = Class 'TextView',
  extends: BaseView

  layout:

    attributes: ['icon', 'tag', 'attach', 'ribbon', 'bordered', 'color']

    style: ->

      ':host':
        display: 'inline-block'
        verticalAlign: baseline
        lineHeight: 1
        margin: theme.margin.small
        backgroundColor: transparent
        border: none
        backgroundImage: none
        textTransform: none
        boxSizing: 'border-box'
        WebkitTransition: 'background .2s ease'
        transition: 'background .2s ease'
        padding: 0
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

      ':host([tag])':
        borderRadius: rem .5
        padding: theme.padding.small
        backgroundColor: theme[if @color? then @color else 'grey'].color
        color: theme[if @color? then @color else 'black'].text

      # ':host([tag]):hover':
        # opacity: .5

      ':host([bordered])':
        borderRadius: rem .3
        padding: theme.padding.small
        border: "1px solid #{theme[if @color then @color else 'white'].text}"

      # ':host(:focus)':
      #   opacity: 1

      # ':host(:active)':
      #   opacity: 1

      ':host(:disabled)':
        pointerEvents: none
        opacity: important .3

      ':host([attach="left"])':
        borderTopLeftRadius: 0
        borderBottomLeftRadius: 0
        paddingRight: em .5

      ':host([attach="right"])':
        borderTopRightRadius: 0
        borderBottomRightRadius: 0
        paddingLeft: em .5

      ':host([attach="top"])':
        borderTopLeftRadius: 0
        borderTopRightRadius: 0
        paddingBottom: em .5

      ':host([attach="bottom"])':
        borderBottomLeftRadius: 0
        borderBottomRightRadius: 0
        paddingTop: em .5

      ':host([ribbon])':
        margin: 0
        padding: theme.padding.small
        backgroundColor: theme[if @color? then @color else 'grey'].color
        color: theme[if @color? then @color else 'black'].text
        minWidth: "'-webkit-max-content'"
        minWidth: "'max-content'"
        borderColor: rgba(0, 0, 0, 0.35)
        zIndex: 1

      ':host([ribbon]):after':
        position: absolute
        content: "''"
        top: '100%'
        left: '0%'
        backgroundColor: important transparent
        borderStyle: 'solid'
        borderWidth: em 0, 1, 1, 0
        borderColor: transparent
        borderRightColor: inherit
        width: em 0
        height: em 0

      ':host([ribbon="left"])':
        WebkitTransform: 'translateX(100%)'
        transform: 'translateX(100%)'
        borderRadius: '0em .3rem .3rem 0em'
        left: '-webkit-calc( -.5rem - .7em )'
        left: 'calc( -.5rem - .7em )'
        marginRight: em -.2
        paddingLeft: '-webkit-calc( .5rem  +  .7em )'
        paddingLeft: 'calc( .5rem  +  .7em )'

      ':host([ribbon="right"])':
        textAlign: left
        WebkitTransform: 'translateX(-100%)'
        transform: 'translateX(-100%)'
        borderRadius: '.3rem 0em 0em .3rem'
        left: '-webkit-calc( .5rem  +  .7em )'
        left: 'calc( .5rem  +  .7em )'
        marginLeft: em -.3
        paddingRight: '-webkit-calc( .5rem  +  .7em )'
        paddingRight: 'calc( .5rem  +  .7em )'

      ':host([ribbon="right"]):after':
        left: auto
        right: '0%'
        borderStyle: 'solid'
        borderWidth: em 1, 1, 0, 0
        borderColor: transparent
        borderTopColor: inherit

    template: renderable (el, content) ->
      if _.isString el.icon
        icon_view el.icon
      span el.textContent


module.exports =

  load: ->
    hazel 'text-view', York.TextView

    expose Text,

      trim:
        desc: "Trims a spaces from string on both sides or left side if <side> is 'l' or right side if <side> if 'r'"
        fn: (side) ->
          if !side?
            return t @value.trim()
          else if side.toLowerCase() == 'l'
            return t @value.trimLeft()
          else if side.toLowerCase() == 'r'
            return t @value.trimRight()
          else
            return t()

  unload: ->
    unexpose Text,

      trim: {}
