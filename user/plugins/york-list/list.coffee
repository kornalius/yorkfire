{ hazel, BaseView, Class, Plugin, expose, unexpose, theme, contents, renderable, color, div, span, text } = York
{ important, auto, none, block, middle, absolute, baseline, inherit, auto, normal, center, transparent, rgba, px, em, rem } = York.css

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
        width: em 10
        height: em 20
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

      '.topspacer':
        width: '100%'

      '.listitem':
        height: px @itemSize


    template: renderable (content) ->
      div '#viewport', layout: true, vertical: true, =>
        if @model?
          div '.topspacer', style: "height: #{@vTop * @itemSize}px"
          for i in [@vTop..@vBottom]
            div '.listitem', layout: true, vertical: true, 'center-center': true, model: @model[i], index: i, "#{i}"

        # if content?
        #   index = 0
        #   for model in @model
        #     content.call(@, model, index++)


  created: ->
    @super()
    @itemSize = 32
    @viewportExpand = @itemSize * 2
    @_oldScrollTop = NaN
    @pTop = 0
    @pBottom = 0
    @pHeight = 0
    @vTop = 0
    @vBottom = 0
    @_oldVTop = NaN
    @_timer = null


  ready: ->
    @super()
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
    @super()
    @viewport$.style.height = "#{@model.length * @itemSize}px"
    @updateItems()


  updateItems: ->
    t = @scrollTop
    if t != @_oldScrollTop
      @_oldScrollTop = t
      @pTop = t - @viewportExpand
      @pBottom = t + @offsetHeight + @viewportExpand
      @pHeight = @pBottom - @pTop
      @vTop = Math.max(Math.trunc(@pTop / @itemSize), 0)
      @vBottom = Math.min(Math.trunc(@pBottom / @itemSize), @model.length - 1)
      if @vTop != @_oldVTop
        @_oldVTop = @vTop
        @refresh()


  '@scroll': (e) ->
    @updateItems()


module.exports =

  load: ->
    hazel 'list-view', York.ListView

  unload: ->
