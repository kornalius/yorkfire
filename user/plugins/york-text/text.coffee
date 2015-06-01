{ Text, t, hazel, BaseView, Class, Plugin, expose, unexpose, theme, renderable, div, span, textarea } = York
{ important, none, auto, inherit, absolute, middle, baseline, relative, left, solid, transparent, rgba, em, rem, px } = York.css


York.TextView = Class 'TextView',
  extends: BaseView

  layout:

    # type = label, input, edit
    # attach = left, right, top, bottom
    # ribbon = left, right, top, bottom
    attributes: ['icon', 'type', 'attach', 'ribbon', 'bordered', 'tag', 'color', 'disabled', 'readonly']

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

      ':host([type="input"][type="edit"])':
        WebkitTransition: none
        transition: none

      ':host([type="input"])':
        verticalAlign: middle

      ':host([type="input"]) .CodeMirror':
        width: em 20
        height: px 20

      ':host([type="input"]) .CodeMirror-hscrollbar':
        minHeight: important px 8

      ':host([type="input"]) .CodeMirror-vscrollbar':
        minWidth: important px 8

      ':host([type="edit"]) .CodeMirror':
        width: em 50
        height: em 20

      ':host([type="edit"]) .CodeMirror div.CodeMirror-cursor':
        borderLeftWidth: important px 8
        opacity: .85


    template: renderable ->
      if @type == 'label'
        if _.isString @icon
          icon_view @icon
        span @textContent

      else if @type == 'input'
        textarea @textContent

      else if @type == 'edit'
        textarea @textContent


  created: ->
    @super()
    @type = 'label'


  attached: ->
    @super()

    if @type == 'input' or @type == 'edit'
      if !window.CodeMirror?
        window.CodeMirror = require('codemirror')
        require('codemirror/mode/coffeescript/coffeescript')
        require('codemirror/mode/javascript/javascript')
        require('codemirror/mode/css/css')
        require('codemirror/mode/htmlmixed/htmlmixed')
        require('codemirror/addon/comment/comment')
        require('codemirror/addon/edit/matchbrackets')
        require('codemirror/addon/edit/closebrackets')
        require('codemirror/addon/edit/matchtags')
        require('codemirror/addon/edit/closetag')
        require('codemirror/addon/scroll/simplescrollbars')

        fs = require('fs')
        path = require('path')

        el = document.createElement('style')
        s = fs.readFileSync(path.join(York.dirs.components, 'codemirror/lib/codemirror.css')).toString()
        s = s.replace new RegExp("(.CodeMirror[^{,]+)", 'gim'), "body /deep/ $1"
        el.innerHTML = s
        document.head.appendChild(el)

        el = document.createElement('style')
        s = fs.readFileSync(path.join(York.dirs.components, 'codemirror/addon/scroll/simplescrollbars.css')).toString()
        s = s.replace new RegExp("(.CodeMirror[^{,]+)", 'gim'), "body /deep/ $1"
        el.innerHTML = s
        document.head.appendChild(el)

        el = document.createElement('style')
        s = fs.readFileSync(path.join(York.dirs.components, 'codemirror/theme/monokai.css')).toString()
        s = s.replace new RegExp("(^.cm-s-[^{,]+)", 'gim'), "body /deep/ $1"
        el.innerHTML = s
        document.head.appendChild(el)

      @editor = CodeMirror.fromTextArea(@_el,
        mode: "text/plain"
        styleActiveLine: @type == 'edit'
        lineNumbers: @type == 'edit'
        firstLineNumber: 1
        lineWrapping: @type == 'edit'
        # scrollbarStyle: 'simple'
        readOnly: @readonly
        lineWiseCopyCut: true
        # moveInputWithCursor: true
        # pollInterval: 100
        disableInput: @disabled
        # resetSelectionOnContextMenu: false
        # maxHighlightLength: 10000
        showCursorWhenSelecting: true
        # singleCursorHeightPerLine: true
        # cursorHeight: 16
        cursorBlinkRate: 500
        # workTime: 100
        # workDelay: 50
        dragDrop: @type == 'edit'
        fixedGutter: true
        # coverGutterNextToScrollbar: true
        # cursorScrollMargin: 2
        # tabindex: if @type == 'input' then -1 else -1
        # placeholder: ''
        autofocus: false
        # flattenSpans: true
        # addModeClass: false
        # maxHighlightLength: 0
        # wholeLineUpdateBefore: false
        # historyEventDelay: 100
        # viewportMargin: 10
        tabSize: 2
        smartIndent: true
        # indentUnit: 2
        indentWithTabs: false
        theme: if @type == 'edit' then 'monokai' else ''
        # keyMap: 'sublime'
        extraKeys:

          Tab: if @type == 'input' then (cm) ->
            el = cm.getTextArea().parentNode.host
            setTimeout ->
              cm.display.cursorDiv.style.visibility = 'hidden'
            next = el
            while next = next.nextSibling
              if !next?
                break
              else if next.editor?
                setTimeout ->
                  next.editor.focus()
                break
      )

      @addEventListener 'click', (e) ->
        e.stopPropagation()

      if @type == 'input'
        @editor.on 'beforeChange', (cm, e) ->
          if e.text.length == 2
            e.cancel()


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
