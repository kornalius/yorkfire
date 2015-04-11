module.exports =

  View: class View

    constructor: (data, def) ->
      { hazel, renderable, div } = York.Hazel

      that = @

      if !def?
        def = data
        data = null

      @el = hazel(_.dasherize(_.uncapitalize(@constructor.name)), _.extend(
        style:
          ':host':
            position: 'relative'
            display: 'inline-block'
            cursor: 'default'

        template: renderable (el, content) ->
          div ->
            if content?
              content(el)

        created: that.created.bind(that)

        destroyed: that.destroyed.bind(that)

        attached: that.attached.bind(that)

        detached: that.detached.bind(that)

        updated: that.updated.bind(that)

      ,def))

      @el.data = data

    @new: (type, data, def) ->
      fn = "./views/#{type}-view.coffee"
      if _.fs.fileExists(fn)
        c = require(fn)
        if c?
          v = new c(data, def)
      return if v? then v else new View()

    updated: ->

    created: ->

    destroyed: ->

    attached: ->

    detached: ->
