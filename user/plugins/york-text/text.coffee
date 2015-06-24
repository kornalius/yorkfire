{ Text, t, BaseView, Class, Plugin, expose, unexpose } = York


York.TextView = Class 'TextView',
  extends: BaseView

  layout:

    # type = label, input, edit
    # attach = left, right, top, bottom
    # ribbon = left, right, top, bottom
    attributes: ['icon', 'type', 'color', 'disabled', 'readonly']


    template: ->
      # if @type == 'label'
      #   if _.isString @icon
      #     icon_view @icon
      #   span @textContent

      # else if @type == 'input'
      #   textarea @textContent

      # else if @type == 'edit'
      #   textarea @textContent


  created: ->
    @super()
    @type = 'label'


module.exports =

  load: ->
    # hazel 'text-view', York.TextView

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
