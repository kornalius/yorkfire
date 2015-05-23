{ Text, t, hazel, BaseView, Class, Plugin, expose, unexpose, theme, renderable, div, span, text } = York
{ important, none, auto, inherit, absolute, baseline, relative, left, solid, transparent, rgba, em, rem } = York.css


York.TextView = Class 'TextView',
  extends: BaseView

  layout:

    # type = label, input, edit
    # attach = left, right, top, bottom
    # ribbon = left, right, top, bottom
    attributes: ['icon', 'type', 'attach', 'ribbon', 'bordered', 'tag', 'color', 'disabled']

    style: ->

      ':host':
        position: relative
        display: 'inline-block'
        verticalAlign: baseline
        lineHeight: 1
        margin: theme.margin.small
        backgroundColor: transparent
        border: none
        backgroundImage: none
        textTransform: none
        boxSizing: 'border-box'
        WebkitTransition: 'background .2s ease'
        transition: 'background .2s ease'
        padding: 0
        color: theme[if @color? then @color else 'white'].text

      '.editor':
        width: em 5
        height: em 1

      ':host([icon]:first-child)':
        marginLeft: em 0

      ':host([icon]:last-child)':
        marginRight: em 0

      'a':
        cursor: 'pointer'
        color: inherit
        opacity: .8
        WebkitTransition: '0.2s opacity ease'
        transition: '0.2s opacity ease'

      'a:hover':
        opacity: 1

      ':host([tag])':
        borderRadius: rem .5
        padding: theme.padding.small
        backgroundColor: theme[if @color? then @color else 'grey'].color
        color: theme[if @color? then @color else 'black'].text

      # ':host([tag]):hover':
        # opacity: .5

      # ':host(:focus)':
      #   opacity: 1

      # ':host(:active)':
      #   opacity: 1

      ':host([bordered])':
        borderRadius: rem .3
        padding: theme.padding.small
        border: "1px solid #{theme[if @color then @color else 'white'].text}"

      ':host(:disabled), :host([disabled]), :host(.disabled)':
        pointerEvents: none
        opacity: important .3

      ':host([attach="left"])':
        borderTopLeftRadius: 0
        borderBottomLeftRadius: 0
        paddingRight: em .5

      ':host([attach="right"])':
        borderTopRightRadius: 0
        borderBottomRightRadius: 0
        paddingLeft: em .5

      ':host([attach="top"])':
        borderTopLeftRadius: 0
        borderTopRightRadius: 0
        paddingBottom: em .5

      ':host([attach="bottom"])':
        borderBottomLeftRadius: 0
        borderBottomRightRadius: 0
        paddingTop: em .5

      ':host([ribbon])':
        margin: 0
        padding: theme.padding.small
        backgroundColor: theme[if @color? then @color else 'grey'].color
        color: theme[if @color? then @color else 'black'].text
        minWidth: "'-webkit-max-content'"
        minWidth: "'max-content'"
        borderColor: rgba(0, 0, 0, 0.35)
        zIndex: 1

      ':host([ribbon]):after':
        position: absolute
        content: "''"
        top: '100%'
        left: '0%'
        backgroundColor: important transparent
        borderStyle: 'solid'
        borderWidth: em 0, 1, 1, 0
        borderColor: transparent
        borderRightColor: inherit
        width: em 0
        height: em 0

      ':host([ribbon="left"])':
        WebkitTransform: 'translateX(100%)'
        transform: 'translateX(100%)'
        borderRadius: '0em .3rem .3rem 0em'
        left: '-webkit-calc( -.5rem - .7em )'
        left: 'calc( -.5rem - .7em )'
        marginRight: em -.2
        paddingLeft: '-webkit-calc( .5rem  +  .7em )'
        paddingLeft: 'calc( .5rem  +  .7em )'

      ':host([ribbon="right"])':
        textAlign: left
        WebkitTransform: 'translateX(-100%)'
        transform: 'translateX(-100%)'
        borderRadius: '.3rem 0em 0em .3rem'
        left: '-webkit-calc( .5rem  +  .7em )'
        left: 'calc( .5rem  +  .7em )'
        marginLeft: em -.3
        paddingRight: '-webkit-calc( .5rem  +  .7em )'
        paddingRight: 'calc( .5rem  +  .7em )'

      ':host([ribbon="right"]):after':
        left: auto
        right: '0%'
        borderStyle: 'solid'
        borderWidth: em 1, 1, 0, 0
        borderColor: transparent
        borderTopColor: inherit

      ':host([type="input"])':
        width: em 20
        height: if @editor? then @editor.renderer.lineHeight + 'px' else '2px'

      '.ace_editor':
        width: '100%'
        height: '100%'

      ':host([type="input"]) .ace_content':
        width: '100%'
        height: '100%'


    template: renderable (el, content) ->
      if el.type == 'label'
        if _.isString el.icon
          icon_view el.icon
        span el.textContent

      else if el.type == 'input'
        div el.textContent


  created: ->
    @super()
    @type = 'label'


  attached: ->
    @super()

    if @type == 'input' or @type == 'edit'
      editor = ace.edit @_el
      @editor = editor
      editor.setBehavioursEnabled(true)

      editor.on 'click', (e) ->
        e.stop()

      aei = setInterval ->
        el = document.getElementById('ace_editor.css')
        if el
          clearInterval aei
          s = el.innerHTML.replace new RegExp("(.ace[_-][^{,]+)", 'gim'), "body /deep/ $1"
          el.innerHTML = s
          editor.setTheme 'ace/theme/monokai'
          themeId = "ace-#{_.last(editor.getTheme().split('/'))}"
          tmi = setInterval ->
            el = document.querySelector('head #' + themeId)
            if el
              clearInterval tmi
              s = el.innerHTML.replace new RegExp("(.ace[_-][^{,]+)", 'gim'), "body /deep/ $1"
              # s = el.innerHTML.replace new RegExp(".#{themeId}", 'gim'), "body /deep/ .#{themeId}"
              el.innerHTML = s
          , 10
      , 10

      ati = setInterval ->
        el = document.querySelector('head #ace-tm')
        if el
          clearInterval ati
          s = el.innerHTML.replace new RegExp("(.ace[_-][^{,]+)", 'gim'), "body /deep/ $1"
          # s = el.innerHTML.replace new RegExp(".ace-tm", 'gim'), "body /deep/ .ace-tm"
          el.innerHTML = s
      , 10

      # # editor.renderer.on 'themeChange', (e) ->
      # #   themeId = "ace-#{_.last(e.theme.split('/'))}"

      if @type == 'input'
        editor.setOptions({maxLines: 1})
        editor.setDisplayIndentGuides(false)
        editor.setHighlightActiveLine(false)
        editor.setWrapBehavioursEnabled(false)
        editor.renderer.setShowGutter(false)
        editor.renderer.setShowPrintMargin(false)
        editor.getSession().setTabSize(2)
        editor.getSession().setUseSoftTabs(true)
        editor.resize()

        # editor.on 'change', (e) ->
        #   if e.data.action == 'insertText' and e.data.text == editor.getNewLineCharacter()
        #     console.log "YES"
        #   console.log e

      # editor.getSession().setMode 'ace/mode/javascript'


module.exports =

  load: ->
    hazel 'text-view', York.TextView

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
