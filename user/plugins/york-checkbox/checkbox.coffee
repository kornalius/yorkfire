{ hazel, hazeling, BaseView, Class, Plugin, expose, unexpose, theme, renderable, div, span } = York
{ important, none, auto, block, inherit, absolute, baseline, relative, hidden, center, middle, left, solid, transparent, rgba, em, rem, px } = York.css

York.CheckboxView = Class 'CheckboxView',
  extends: BaseView

  layout:

    attributes: ['type', 'fitted', 'color', 'checked', 'disabled', 'on-click']

    style: ->

      ':host':
        position: relative
        display: 'inline-block'
        minHeight: px 17
        fontSize: rem 1
        lineHeight: px 15
        minWidth: px 17
        WebkitBackfaceVisibility: hidden
        backfaceVisibility: hidden
        outline: none
        verticalAlign: middle
        cursor: 'default'

      ':host([type="checkbox"]) .label':
        display: block
        fontSize: em 1
        color: theme.black.color
        WebkitTransition: 'color .2s ease'
        transition: 'color .2s ease'
        WebkitUserSelect: none
        userSelect: none
        # verticalAlign: middle
        paddingLeft: em 1.75
        outline: none

      ':host([type="checkbox"]) .label:before':
        position: absolute
        lineHeight: 1
        width: px 17
        height: px 17
        top: px -5
        left: px -3
        content: "''"
        padding: px 1
        background: '#ffffff'
        borderRadius: em .25
        WebkitTransition: 'background-color .3s ease, border .3s ease, box-shadow .3s ease'
        transition: 'background-color .3s ease, border .3s ease, box-shadow .3s ease'
        border: '1px solid #d4d4d5'

      ':host([type="checkbox"]) .label:hover:before':
        background: '#ffffff'
        border: '1px solid rgba(39, 41, 43, .4)'

      ':host([type="checkbox"]) .label:hover':
        color: rgba(0, 0, 0, .8)

      ':host([type="checkbox"][checked=true]) .label:before':
        background: theme.grey.dark
        border: '1px solid rgba(39, 41, 43, .4)'
        backgroundClip: 'content-box'

      ':host([type="checkbox"]) .label:active:before':
        background: '#f5f5f5'
        border: '1px solid rgba(39, 41, 43, .4)'

      ':host([type="checkbox"]) .label:active':
        color: rgba(0, 0, 0, .8)

      ':host([type="checkbox"]) .label:focus:before':
        background: '#f5f5f5'
        border: '1px solid 1px solid rgba(39, 41, 43, .4)'

      ':host([type="checkbox"]) .label:focus':
        color: rgba(0, 0, 0, .8)

      ':host([disabled]) .label:before, :host(:disabled) .label:before':
        opacity: .5
        color: '#000000'

      ':host([disabled]) .label, :host(:disabled) .label, :host([disabled]) .label':
        opacity: .5
        color: '#000000'

      # ':host([type="radio"])':
      #   minHeight: px 14

      # ':host([type="radio"]) .box:before, :host([type="radio"]) .label:before':
      #   width: px 14
      #   height: px 14
      #   borderRadius: rem 500
      #   top: px 1
      #   left: px 0
      #   WebkitTransform: none
      #   transform: none

      # ':host([type="radio"]) .box:after, :host([type="radio"]) .label:after':
      #   border: none
      #   width: px 14
      #   height: px 14
      #   lineHeight: px 14
      #   top: px 1
      #   left: px 0
      #   fontSize: px 9

      # ':host([type="radio"]) .box:after, :host([type="radio"]) .label:after':
      #   width: px 14
      #   height: px 14
      #   borderRadius: rem 500
      #   WebkitTransform: 'scale(.42857143)'
      #   transform: 'scale(.42857143)'
      #   backgroundColor: rgba(0, 0, 0, .8)

      # ':host([type="toggle"])':
      #   cursor: 'default'
      #   minHeight: rem 1.5

      # ':host([type="toggle"]) .box, :host([type="toggle"]) .label':
      #   minHeight: rem 1.5
      #   paddingLeft: rem 4.5
      #   color: rgba(0, 0, 0, .8)

      # ':host([type="toggle"]) .label':
      #   paddingTop: em .15

      # ':host([type="toggle"]) .box:before, :host([type="toggle"]) .label:before':
      #   cursor: 'default'
      #   display: block
      #   position: absolute
      #   content: "''"
      #   top: rem 0
      #   zIndex: 1
      #   border: none
      #   backgroundColor: rgba(0, 0, 0, .05)
      #   width: rem 3.5
      #   height: rem 1.5
      #   borderRadius: rem 500

      # ':host([type="toggle"]) .box:after, :host([type="toggle"]) .label:after':
      #   background: '#ffffff -webkit-linear-gradient(transparent, rgba(0, 0, 0, .05))'
      #   background: '#ffffff linear-gradient(transparent, rgba(0, 0, 0, .05))'
      #   position: absolute
      #   content: "''"
      #   opacity: 1
      #   zIndex: 2
      #   border: none
      #   boxShadow: '0px 1px 2px 0 rgba(0, 0, 0, .05), 0px 0px 0px 1px rgba(39, 41, 43, .15) inset'
      #   width: rem 1.5
      #   height: rem 1.5
      #   top: rem 0
      #   left: em 0
      #   borderRadius: rem 500
      #   WebkitTransition: 'background .3s ease 0s, left .3s ease 0s'
      #   transition: 'background .3s ease 0s, left .3s ease 0s'

      # ':host([toggle checkbox]) ~ .box:after, :host([toggle checkbox]) ~ .label:after, :host([toggle radio]) ~ .box:after, :host([toggle radio]) ~ .label:after':
      #   left: rem -.05

      # ':host([toggle checkbox]):focus ~ .box:before, :host([toggle checkbox]):focus ~ .label:before, :host([toggle radio]):focus ~ .box:before, :host([toggle radio]):focus ~ .label:before':
      #   backgroundColor: rgba(0, 0, 0, .1)
      #   border: none

      # ':host([type="toggle"]) .box:hover::before, :host([type="toggle"]) .label:hover::before':
      #   backgroundColor: rgba(0, 0, 0, .1)
      #   border: none

      # ':host([toggle checkbox]):checked ~ .box, :host([toggle checkbox]):checked ~ .label, :host([toggle radio]):checked ~ .box, :host([toggle radio]):checked ~ .label':
      #   color: '#5bbd72'

      # ':host([toggle checkbox]):checked ~ .box:before, :host([toggle checkbox]):checked ~ .label:before, :host([toggle radio]):checked ~ .box:before, :host([toggle radio]):checked ~ .label:before':
      #   backgroundColor: '#5bbd72'

      # ':host([toggle checkbox]):checked ~ .box:after, :host([toggle checkbox]):checked ~ .label:after, :host([toggle radio]):checked ~ .box:after, :host([toggle radio]):checked ~ .label:after':
      #   left: rem 2.05

      # ':host([fitted checkbox]) .box, :host([fitted checkbox]) .label':
      #   paddingLeft: important em 0

      # ':host([fitted toggle checkbox]), :host([fitted toggle checkbox])':
      #   width: rem 3.5

      # ':host([fitted slider checkbox]), :host([fitted slider checkbox])':
      #   width: rem 3.5

      # ':host([type="checkbox"]) .label:before, :host([type="checkbox"]) .box:before, :host([type="checkbox"]) .label:after, :host([type="checkbox"]) .box:after':
      #   fontFamily: 'Checkbox'

      # ':host([type="checkbox"]) .label:after, :host([type="checkbox"]) .box:after':
      #   content: '\e800'


    template: renderable (el, content) ->
      text_view '.label', el.textContent


  created: ->
    @super()
    @type = 'checkbox'

  attached: ->
    @super()
    @attr 'checked', false

    $(@).on 'click', (e) ->
      if !e.currentTarget.disabled
        console.log "CHECKBOX", e.currentTarget, e.currentTarget.checked
        e.currentTarget.attr('checked', if e.currentTarget.attr('checked') == 'true' then false else true)
        e.stopPropagation()


module.exports =

  load: ->
    hazel 'checkbox-view', York.CheckboxView

  unload: ->
