module.exports =

  DesktopView: class DesktopView extends York.View

    constructor: ->
      { renderable, div, span } = York.Hazel

      super(

        style:
          ':host':
            display: 'block'
            position: 'absolute'
            color: 'white'
            width: '100%'
            height: '100%'
            backgroundColor: 'black'
          '#text':
            display: 'inline-block'
            margin: '16px'

        template: renderable (el, content) ->
          div ->
            span '#text', "DESKTOP"
            span '#text', "DESKTOP"

      )

    updated: ->
