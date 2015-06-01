{ hazel, hazeling, color, BaseView, Class, Plugin, expose, unexpose, theme, renderable, div, span } = York
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

      '.label:hover:before':
        background: theme.white.light
        border: '1px solid rgba(39, 41, 43, .4)'

      '.label:hover':
        color: rgba(0, 0, 0, .8)

      '.label:active:before':
        background: '#f5f5f5'
        border: '1px solid rgba(39, 41, 43, .4)'

      '.label:active':
        color: rgba(0, 0, 0, .8)

      '.label:focus:before':
        background: '#f5f5f5'
        border: '1px solid 1px solid rgba(39, 41, 43, .4)'

      '.label:focus':
        color: rgba(0, 0, 0, .8)

      ':host([disabled])':
        pointerEvents: none

      ':host([disabled]) .label:before, :host([disabled]) .label':
        opacity: .5
        color: '#000000'

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
        background: theme.white.light
        borderRadius: em .25
        WebkitTransition: 'background-color .3s ease, border .3s ease, box-shadow .3s ease'
        transition: 'background-color .3s ease, border .3s ease, box-shadow .3s ease'
        border: '1px solid #d4d4d5'

      ':host([type="checkbox"][checked]) .label:before':
        background: theme.grey.dark
        border: '1px solid rgba(39, 41, 43, .4)'
        borderRadius: em .25
        backgroundClip: 'content-box'

      ':host([type="radio"])':
        minHeight: px 14

      ':host([type="radio"]) .label':
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

      ':host([type="radio"]) .label:before':
        position: absolute
        lineHeight: 1
        width: px 14
        height: px 14
        top: px -5
        left: px -3
        content: "''"
        padding: px 3
        background: theme.white.light
        borderRadius: rem 500
        WebkitTransition: 'background-color .3s ease, border .3s ease, box-shadow .3s ease'
        transition: 'background-color .3s ease, border .3s ease, box-shadow .3s ease'
        border: '1px solid #d4d4d5'

      ':host([type="radio"][checked]) .label:before':
        background: theme.grey.dark
        border: '1px solid rgba(39, 41, 43, .4)'
        backgroundClip: 'content-box'

      ':host([type="toggle"])':
        cursor: 'default'
        minHeight: rem 1.5

      ':host([type="toggle"]) .label':
        display: block
        fontSize: em 1
        color: theme.black.color
        WebkitTransition: 'color .2s ease'
        transition: 'color .2s ease'
        WebkitUserSelect: none
        userSelect: none
        # verticalAlign: middle
        paddingLeft: em 3
        outline: none

      ':host([type="toggle"]) .label:before':
        position: absolute
        lineHeight: 1
        width: em 2.5
        height: px 17
        top: px -5
        left: 0
        content: "''"
        padding: px 1
        background: theme.white.light
        borderRadius: em .25
        WebkitTransition: 'background-color .3s ease, border .3s ease, box-shadow .3s ease'
        transition: 'background-color .3s ease, border .3s ease, box-shadow .3s ease'
        border: '1px solid #d4d4d5'

      ':host([type="toggle"]) .label:after':
        position: absolute
        background: theme.grey.light
        lineHeight: 1
        width: em 1.25
        height: px 17
        left: em 1.3
        top: px -4
        content: "''"
        padding: px 1
        WebkitTransition: 'background-color .3s ease, border .3s ease, box-shadow .3s ease'
        transition: 'background-color .3s ease, border .3s ease, box-shadow .3s ease'
        border: none
        backgroundClip: 'content-box'

      ':host([type="toggle"][checked]) .label:after':
        background: theme.grey.dark
        left: px 1
        borderRadius: '.25em 0 0 .25em'
        backgroundClip: 'content-box'


    template: renderable ->
      text_view '.label', @textContent


  created: ->
    @super()
    @type = 'checkbox'

  attached: ->
    @super()

    @on 'click', (e) ->
      el = e.currentTarget
      if !el.isDisabled()
        el.attr 'checked', el.attr('checked') != 'true'
        e.stopPropagation()


module.exports =

  load: ->
    hazel 'checkbox-view', York.CheckboxView

  unload: ->
