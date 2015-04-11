module.exports =

  TextView: class TextView extends York.View

    constructor: (data, def) ->
      { renderable, span } = York.Hazel

      super(data, _.extend(

        template: renderable (el, content) ->
          span "#{el.data()}"

        ,def)
      )

    updated: ->
