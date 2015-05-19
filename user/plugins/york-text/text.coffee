{ Class, Plugin, expose, unexpose, Text, t } = York

module.exports =

  load: ->

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
