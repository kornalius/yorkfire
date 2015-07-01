{ Text, t, hazel, BaseView, TerminalView, Class, Plugin, expose, unexpose, theme, renderable, div, table, td, tr } = York
{ important, none, auto, inherit, absolute, block, middle, baseline, relative, left, solid, transparent, rgba, em, rem, px } = York.css


York.WindowCaptionView = Class 'WindowCaptionView',
  extends: TerminalView

  layout:

    attributes: ["caption"]

    style: ->
      ':host':
        width: '100%'
        display: 'block'
        # display: 'flex'
        # flexDirection: 'column'
        # alignItems: 'center'
        # justifyContent: 'center'

      # '.terminal':
        # display: block


  created: ->
    @super()

    @fg = 'white'
    @bg = '#6666ff'
    @cols = 80
    @rows = 1
    @cursorblink = false
    @usefocus = false
    @usemouse = false
    @useevents = false


  attached: ->
    @super()
    @terminal.write(@caption)


  '@mousedown': (e) ->
    that = @parentWindow
    if !window.moving? and !window.resizing?
      window.moving = that
      window.moving._oldX = e.clientX
      window.moving._oldY = e.clientY
      window.moving._dx = e.clientX - that.offsetLeft
      window.moving._dy = e.clientY - that.offsetTop
      # e.stopPropagation()

  # '@focusin': (e) ->
  #   e.stopPropagation()

  # '@mouseup': (e) ->
  #   e.stopPropagation()


York.WindowBorderView = Class 'WindowBorderView',
  extends: BaseView

  layout:

    attributes: ["side"]

    style: ->
      ':host':
        display: block
        position: absolute
        zIndex: 1
        backgroundColor: transparent
        userSelect: none
        WebkitUserSelect: none
        WebkitTapHighlightColor: transparent

      ':host([side="left"])':
        left: '-4px'
        top: '-4px'
        right: '100%'
        bottom: '-4px'
        cursor: 'ew-resize'

      ':host([side="right"])':
        left: '100%'
        top: '-4px'
        right: '-4px'
        bottom: '-4px'
        cursor: 'ew-resize'

      ':host([side="top"])':
        left: '-4px'
        top: '-4px'
        bottom: '100%'
        right: '-4px'
        cursor: 'ns-resize'

      ':host([side="bottom"])':
        left: '-4px'
        top: '100%'
        bottom: '-4px'
        right: '-4px'
        cursor: 'ns-resize'

      ':host([side="topleft"])':
        left: '-4px'
        top: '-4px'
        paddingRight: '8px'
        paddingBottom: '8px'
        cursor: 'nwse-resize'
        zIndex: '1'

      ':host([side="bottomleft"])':
        left: '-4px'
        bottom: '-4px'
        paddingTop: '8px'
        paddingRight: '8px'
        cursor: 'nesw-resize'
        zIndex: '1'

      ':host([side="topright"])':
        top: '-4px'
        right: '-4px'
        paddingLeft: '8px'
        paddingBottom: '8px'
        cursor: 'nesw-resize'
        zIndex: '1'

      ':host([side="bottomright"])':
        right: '-4px'
        bottom: '-4px'
        paddingLeft: '8px'
        paddingTop: '8px'
        cursor: 'nwse-resize'
        zIndex: '1'


  created: ->
    @super()
    @noTemplate = true


  '@mousedown': (e) ->
    that = @parentWindow
    if !window.moving? and !window.resizing?
      window.resizing = that
      window.resizing._border = e.currentTarget
      window.resizing._oldX = e.clientX
      window.resizing._oldY = e.clientY


York.WindowContentView = Class 'WindowContentView',
  extends: TerminalView

  layout:

    attributes: []

    style: ->
      ':host':
        width: '100%'
        height: '100%'
        display: 'block'
        # flexDirection: 'column'
        # alignItems: 'center'
        # justifyContent: 'center'

      # '.terminal':
        # display: block

  attached: ->
    @super()
    @terminal.write('\x1b[?7h\x1b[31mWelcome to term.js!\x1b[m\r\n')
    @terminal.write('\uf0a1 \uf187 \uf073 \uf0f4 \uf1c0 \uf0e0 kldshjklsajd klasj dklas jdklasjl kd jaskldj askldhajskdh kj asdhasj daksljd klasjdkl asjdlj asdklj aksldj aklsdj klasj dklasj kldajs klj lkj\r\n')
    @terminal.write('123456789-123456789-123456789-123456789-123456789-123456789-123456789-123456789-\r\n')


York.WindowView = Class 'WindowView',
  extends: BaseView

  layout:

    attributes: []

    style: ->

      ':host':
        border: '4px solid black'
        borderRadius: '4px'
        backgroundColor: if @content$? then @content$.bg else 'white'
        userSelect: 'none'
        WebkitUserSelect: 'none'
        WebkitTapHighlightColor: 'transparent'

      '.window':
        height: '100%'
        width: '100%'
        # display: 'flex'
        # flexDirection: 'column'


    template: renderable ->
      div '.window', ->
        windowCaptionView '#caption.caption', caption: 'TITLE'
        windowContentView '#content.content'
        windowBorderView '#borderLeft.border', side: 'left'
        windowBorderView '#borderTop.border', side: 'top'
        windowBorderView '#borderRight.border', side: 'right'
        windowBorderView '#borderBottom.border', side: 'bottom'
        windowBorderView '#borderTopleft.border', side: 'topleft'
        windowBorderView '#borderTopright.border', side: 'topright'
        windowBorderView '#borderBottomleft.border', side: 'bottomleft'
        windowBorderView '#borderBottomright.border', side: 'bottomright'


  attached: ->
    @super()

    @caption$.parentWindow = @
    @content$.parentWindow = @
    @borderLeft$.parentWindow = @
    @borderTop$.parentWindow = @
    @borderRight$.parentWindow = @
    @borderBottom$.parentWindow = @
    @borderTopleft$.parentWindow = @
    @borderTopright$.parentWindow = @
    @borderBottomleft$.parentWindow = @
    @borderBottomright$.parentWindow = @


module.exports =

  load: ->
    hazel 'window-caption-view', York.WindowCaptionView
    hazel 'window-border-view', York.WindowBorderView
    hazel 'window-content-view', York.WindowContentView
    hazel 'window-view', York.WindowView

    $(document.body).on('mousemove', (e) ->
      if window.moving?
        m = window.moving
        m.style.left = "#{e.clientX - m._dx}px"
        m.style.top = "#{e.clientY - m._dy}px"
        m._oldX = e.clientX
        m._oldY = e.clientY

      else if window.resizing?
        r = window.resizing
        caption = r.caption$
        content = r.content$
        term = content.terminal
        tterm = caption.terminal
        s = getComputedStyle(content, null)
        l = r.offsetLeft
        t = r.offsetTop
        w = r.clientWidth
        h = r.clientHeight
        cw = content.charWidth
        ch = content.charHeight
        if r._border.side == 'left'
          d = e.clientX - r._oldX
          l = e.clientX
          r.style.left = "#{l}px"
          w = (w - d)
          r.style.width = "#{w}px"
        else if r._border.side == 'right'
          w = (e.clientX - l)
          r.style.width = "#{w}px"
        else if r._border.side == 'top'
          d = e.clientY - r._oldY
          t = e.clientY
          r.style.top = "#{t}px"
          h = h - d
          r.style.height = "#{h}px"
        else if r._border.side == 'bottom'
          h = e.clientY - t
          r.style.height = "#{h}px"
        else if r._border.side == 'topleft'
          d = e.clientX - r._oldX
          l = e.clientX
          r.style.left = "#{l}px"
          w = (w - d)
          r.style.width = "#{w}px"
          d = e.clientY - r._oldY
          t = e.clientY
          r.style.top = "#{t}px"
          h = h - d
          r.style.height = "#{h}px"
        else if r._border.side == 'topright'
          w = (e.clientX - l)
          r.style.width = "#{w}px"
          d = e.clientY - r._oldY
          t = e.clientY
          r.style.top = "#{t}px"
          h = h - d
          r.style.height = "#{h}px"
        else if r._border.side == 'bottomleft'
          d = e.clientX - r._oldX
          l = e.clientX
          r.style.left = "#{l}px"
          w = (w - d)
          r.style.width = "#{w}px"
          h = e.clientY - t
          r.style.height = "#{h}px"
        else if r._border.side == 'bottomright'
          w = (e.clientX - l)
          r.style.width = "#{w}px"
          h = e.clientY - t
          r.style.height = "#{h}px"
        nx = Math.trunc((w - 8) / cw)
        ny = Math.trunc((h - 16) / ch) - 1
        term.resize(nx, ny);
        tterm.resize(nx, 1);
        r._oldX = e.clientX
        r._oldY = e.clientY
    )

    $(document.body).on('mouseup', (e) ->
      window.moving = null
      window.resizing = null
      window.resizingBorder = null
    )


  unload: ->
    $(document.body).off('mousemove')
    $(document.body).off('mouseup')
