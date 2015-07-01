{ Text, t, hazel, BaseView, Class, Plugin, expose, unexpose, loadCSS, dirs, path, theme, renderable, div } = York
{ important, none, auto, inherit, absolute, middle, baseline, relative, left, solid, transparent, rgba, em, rem, px } = York.css
Term = require('term.js').Terminal


York.TerminalView = Class 'TerminalView',
  extends: BaseView

  layout:

    attributes: ['cols', 'rows', 'fg', 'bg', 'font', 'fontsize', 'screenkeys', 'cursorblink', 'usefocus', 'usemouse', 'useevents', 'colors', 'border', 'bordersize', 'bordercolor', 'disabled', 'readonly']

    style: ->

      ':host':
        display: 'inline-block'
        position: relative
        overflow: 'hidden'

      '.terminal':
        display: 'block'
        position: 'relative'
        borderStyle: "#{if @bordersize? then 'solid' else 'none'}"
        borderWidth: "#{if @bordersize? then @bordersize else 0}px"
        borderColor: "#{if @bordercolor? then @bordercolor else 'transparent'}"
        borderRadius: "#{if @borderradius? then @borderradius else 0}px"
        padding: "4px"
        color: @fg
        background: "#{@bg} !important"
        fontFamily: "\"#{@font}\", \"FontAwesome\", monospace"
        fontSize: "#{@fontsize}px"
        lineHeight: 'initial'
        cursor: 'default'
        userSelect: 'none'
        WebkitUserSelect: 'none'
        WebkitTapHighlightColor: 'transparent'

      '.terminal .terminal-cursor':
        color: @bg
        background: @fg


  created: ->
    @super()

    @noTemplate = true

    @fg = 'white'
    @bg = '#191919'
    @font = 'Glass_TTY_VT220'
    @fontsize = 20
    @cols = 80
    @rows = 24
    @screenkeys = true
    @usestyle = false
    @cursorblink = true
    @usefocus = true
    @usemouse = true
    @useevents = true
    @colors = Term.tangoColors


  attached: ->
    @super()

    console.log 'terminal.attached', @

    @terminal = new Term(
      fg: @fg
      bg: @bg
      cols: @cols
      rows: @rows
      screenKeys: @getAttribute('@screenkeys') == 'true'
      useStyle: @getAttribute('@usestyle') == 'true'
      cursorBlink: @getAttribute('cursorblink') == 'true'
      useFocus: @getAttribute('@usefocus') == 'true'
      useMouse: @getAttribute('@usemouse') == 'true'
      useEvents: @getAttribute('@useevents') == 'true'
      colors: @colors
    )
    @terminal.open(@shadowRoot)

    @charWidth = @terminal.children[0].clientWidth / @cols
    @charHeight = @terminal.children[0].clientHeight


module.exports =

  load: ->
    hazel 'terminal-view', York.TerminalView

  unload: ->

