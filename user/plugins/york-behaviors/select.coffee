{ hazel, Class, Plugin, expose, unexpose, theme, renderable } = York

York.SelectBehavior = Class 'SelectBehavior',
  extends: York.BaseBehavior

  constructor: ->
    @super()


  layout:

    attributes: ['selected']

    style: ->
      ':host(.selected)':
        backgroundColor: theme.selection.color
        color: theme.selection.text


  '@click': (e) ->
    console.log 'selected', e
    @toggleSelect()

  select: (selected) ->
    if selected != @selected and @isEnabled()
      @selected = selected
      if selected then @onSelect() else @onDeselect()

  toggleSelect: ->
    @select(!@selected)

  onSelect: ->
    @addClass 'selected'

  onDeselect: ->
    @removeClass 'selected'
