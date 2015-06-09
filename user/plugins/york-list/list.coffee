{ hazel, BaseView, Class, Plugin, expose, unexpose, theme, contents, renderable, color, div, span } = York
{ important, none, baseline, inherit, auto, normal, center, transparent, rgba, em, rem } = York.css

York.ListView = Class 'ListView',
  extends: BaseView

  layout:

    attributes: ['model', 'color', 'disabled', 'allowSelection', 'multi', 'type']

    style: ->

      ':host':
        cursor: 'default'
        display: 'inline-block'
        minWidth: em 5
        minHeight: em 4
        height: em 4
        outline: none
        border: "1px solid #{theme[if @color? then @color else 'grey'].color}"
        verticalAlign: baseline
        padding: em .5
        textTransform: none
        textShadow: none
        fontWeight: normal
        fontStyle: normal
        lineHeight: 1
        textDecoration: none
        backgroundImage: none
        WebkitUserSelect: none
        userSelect: none
        overflow: auto
        # WebkitTransition: 'opacity .1s ease, background-color .1s ease, color .1s ease, box-shadow .1s ease, background .1s ease'
        # transition: 'opacity .1s ease, background-color .1s ease, color .1s ease, box-shadow .1s ease, background .1s ease'
        willChange: none
        WebkitTapHighlightColor: transparent
        # boxShadow: '0px 0px 0px 1px transparent inset, 0px 0em 0px 0px rgba(39, 41, 43, .15) inset'
        backgroundColor: theme[if @color? then @color else 'white'].color
        color: theme[if @color? then @color else 'white'].text

      ':host(:hover)':
        borderColor: rgba 0, 0, 0, .5

      ':host(:focus)':
        borderColor: rgba 0, 0, 0, .5

      # ':host(:active), :host(.active), :host([active])':

      # ':host(:active:hover), :host(.active:hover), :host([active]):hover':

      ':host([disabled])':
        cursor: 'default'
        backgroundColor: important '#dcddde'
        color: important rgba(0, 0, 0, .4)
        opacity: important .3
        pointerEvents: none


    template: renderable (content) ->
      div '#viewport', =>
        if content?
          index = 0
          for model in @model
            content.call(@, model, index++)


  created: ->
    @vStart = 0
    @vEnd = 0
    @size = 14
    @overflowItems = 4
    @elements = []


  ready: ->
    if !@model?
      @model = []
    for i in [0..250]
      @model = @model.concat [
        {name: 'Alain'},
        {name: 'Melissa'},
        {name: 'Ariane'},
        {name: 'Maggie'},
        {name: 'Clermont'},
        {name: 'Jocelyne'},
        {name: 'Gaston'},
        {name: 'Suzanne'},
        {name: 'Veronique'}
      ]


  attached: ->
    @elements.length = Math.trunc(@offsetHeight / @size)
    y = 0
    for i in [0...@elements.length]
      el = document.createElement('div')
      el.style.width = '50%'
      el.style.height = "#{@size}px"
      el.style.display = 'block'
      el.style.position = 'absolute'
      el.style.top = "#{y}px"
      el.style.left = "0px"
      el.style.backgroundColor = color().rgb(y / 100 * 255, 100, 100).hexString()
      @_viewport.appendChild(el)
      y += @size


  '@scroll': (e) ->
    @vStart = Math.trunc(@scrollTop / @size)
    console.log @, @vStart


module.exports =

  load: ->
    hazel 'list-view', York.ListView

  unload: ->
