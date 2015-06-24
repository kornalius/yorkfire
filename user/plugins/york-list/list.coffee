{ BaseView, Class, Plugin, expose, unexpose } = York


York.ListView = Class 'ListView',
  extends: BaseView

  layout:

    attributes: ['model', 'color', 'disabled', 'allowSelection', 'multi', 'type']

    template: (content) ->
      # if @model?
      #   div '.topspacer', style: "height: #{@vTop * @itemSize}px"
      #   for i in [@vTop..@vBottom]
      #     div '.listitem', layout: true, vertical: true, 'center-center': true, model: @model[i], index: i, "#{i}"


  created: ->
    @super()
    @itemSize = 1
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


  # '@scroll': (e) ->
    # @updateItems()


module.exports =

  load: ->
    # hazel 'list-view', York.ListView

  unload: ->
