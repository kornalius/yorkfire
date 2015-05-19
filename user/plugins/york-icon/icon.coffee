{ hazel, BaseView, Class, Plugin, path, loadCSS, expose, unexpose, theme, renderable, i } = York
{ important, none, inherit, hidden, normal, center, middle, baseline, middle, rgba, em, rem, pointer } = York.css

York.IconView = Class 'IconView',
  extends: BaseView

  layout:

    attributes: ['link', 'tag', 'circular', 'hflip', 'vflip', 'bordered', 'small', 'large', 'color']

    style: ->

      ':host .cic':
        display: 'inline-block'
        opacity: 1
        margin: rem .25
        width: em 1.23
        height: em .9
        # verticalAlign: middle
        fontFamily: 'cicons'
        fontStyle: normal
        fontWeight: normal
        textDecoration: inherit
        textAlign: center
        lineHeight: em 1
        speak: none
        fontSmoothing: 'antialiased'
        MozOsxFontSmoothing: 'grayscale'
        WebkitBackfaceVisibility: hidden
        backfaceVisibility: hidden
        color: theme[if @color? then @color else 'black'].color

      ':host(:before) .cic':
        background: important none

      ':host([link]) .cic':
        cursor: pointer
        opacity: .8
        WebkitTransition: 'opacity .2s ease'
        transition: 'opacity .2s ease'

      ':host([link]) .cic:hover':
        opacity: important 1

      ':host([circular]) .cic':
        backgroundColor: theme[if @color? then @color else 'grey'].color
        color: theme[if @color? then @color else 'grey'].text
        borderRadius: important em 500
        # padding: important em .5, .5
        boxShadow: '0em 0em 0em .1em rgba(0, 0, 0, 0.1) inset'
        lineHeight: important em 2
        width: important em 2
        height: important em 2
        verticalAlign: middle

      ':host([tag]) .cic':
        backgroundColor: theme[if @color? then @color else 'grey'].color
        color: theme[if @color? then @color else 'grey'].text
        borderRadius: important em .25
        padding: important theme.padding.small
        boxShadow: '0em 0em 0em .1em rgba(0, 0, 0, 0.1) inset'
        # lineHeight: important em 2
        # width: important em 2
        # height: important em 2

      ':host([hflip]) .cic':
        WebkitTransform: 'scale(-1, 1)'
        transform: 'scale(-1, 1)'

      ':host([vflip]) .cic':
        WebkitTransform: 'scale(1, -1)'
        transform: 'scale(1, -1)'

      ':host([bordered]) .cic':
        # width: '2em'
        # height: '2em'
        padding: important em .5, .5
        boxShadow: '0em 0em 0em 0.1em rgba(0, 0, 0, 0.25) inset'
        verticalAlign: baseline

      ':host([small]) .cic':
        fontSize: em .8

      ':host([large]) .cic':
        fontSize: em 2


    template: renderable (el, content) ->
      i ".cic.cic-#{el.textContent}"


module.exports =

  load: ->
    loadCSS(path.join(__dirname, 'cicons.css'), { url: path.join(__dirname, 'fonts') })

    hazel 'icon-view', York.IconView

  unload: ->
