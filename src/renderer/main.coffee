bonzo = require('bonzo')

window.ccss = require 'ccss'

window._ = require('lodash')
_.mixin(require('underscore.string').exports())
_.is = require('is')

window.$ = (selector) ->
  if _.isString(selector)
    if _.startsWith(selector, '<')
      bonzo.create(selector)
    else
      bonzo(document.querySelector(selector))
  else
    bonzo(selector)

Hazel = require('../../hazel/hazel.coffee')

{ hazel, renderable, span, div, text, input } = Hazel

# for k, v of Hazel
#   window[k] = v

hazel 'baseElement',
  style:
    ':host':
      'display': 'inline-block'
    'div':
      'background-color': 'orange'
      padding: '2px'

  template: renderable (el, content) ->
    div ->
      if content?
        content(el)
      else
        span "component #{@tagName}"

  methods:
    method0: ->
      console.log 'method0', @


hazel 'myBaseElement',
  extends: 'base-element'

  style:
    ':host':
      'background-color': 'blue'
      'color': 'white'
      margin: '4px'
      padding: '4px'

  template: renderable (el) ->
    div ->
      span "component #{el.tagName}"

  methods:
    method1: ->
      console.log 'method1', @


hazel 'my element',
  extends: 'baseElement'

  style:
    ':host':
      'background-color': 'red'
      margin: '4px'
      padding: '8px'
      'border-radius': '4px'
    '#my-input':
      'margin': '4px 8px'
      'background-color': 'yellow'

  data:
    inputValue: 'something'

  template: renderable (el) ->
    div ->
      input '#my-input.my-class', type: 'text', value: 'inputValue'
      text el.tagName

  methods:
    method0: ->
      console.log 'method0.1', @

    method1: ->
      console.log 'method1', @

    method2: ->
      console.log 'method2', @


el = document.createElement('my-element')
document.querySelector('body').appendChild(el)
el.method0()

el = document.createElement('my-base-element')
document.querySelector('body').appendChild(el)
el.method0()

el = document.createElement('base-element')
document.querySelector('body').appendChild(el)
el.method0()



# ********** REACT ***********

# ReactShadow = require('react-shadow')
# React = require('react')
# ReactMixin = require('react-mixin')

# build_tag = (tag) ->
#   (options...) ->
#     options.unshift {} if options[0]['_isReactElement'] or options[0].constructor isnt Object
#     React.DOM[tag].apply @, options

# DOM = (->
#   object = {}
#   for element in Object.keys(React.DOM)
#     object[element] = build_tag element
#   object
# )()

# {h1, h2, div} = DOM

# CounterClass = React.createClass(
#   propTypes: initialCount: React.PropTypes.number
#   defaultProps: initialCount: 0
#   mixins: [ReactShadow]
#   cssSource: ":host { color: red; }"

#   tick: =>
#     @setState count: @state.count + 1

#   render: ->
#     div onClick: =>
#       @setState count: @state.count + 10
#     , "Clicks: #{@state.count}"
# )

# el = React.createElement(CounterClass, initialCount: 20)
# d2 = document.createElement('div')
# c2 = React.render(el, d2)
# document.body.appendChild(d2)

# Counter = React.createFactory(class CounterComponent extends React.Component
#   @propTypes = initialCount: React.PropTypes.number
#   @defaultProps = initialCount: 0

#   @cssSource = ":host { color: red; }"

#   constructor: (props) ->
#     super props
#     @state =
#       count: props.initialCount
#       interval: setInterval(@tick, 1000)

#   tick: =>
#     @setState count: @state.count + 1

#   render: ->
#     div onClick: =>
#       @setState count: @state.count + 10
#     , "Clicks: #{@state.count}"
# )

# c = Counter(initialCount: 10)
# d1 = document.createElement('div')
# c1 = React.render(c, d1)

# el = React.createElement(CounterComponent, initialCount: 20)
# d2 = document.createElement('div')
# c2 = React.render(el, d2)

# document.body.appendChild(d1)
# document.body.appendChild(d2)

# ReactMixin(CounterComponent.prototype, ReactShadow)

# # el = React.createElement('p', null, 'This is some text')
# # console.log el
# # React.render(el, document.body)

# # el = React.DOM.p(null, 'This is some text')
# # console.log el
# # React.render(el, document.body)


# *********** VueJS ***********

# Vue = require('vue')
# Vue.config.debug = true
# { render, tag, div, span  } = require('teacup')

# Vue.component('my-component',
#   paramAttributes: ['c']

#   template: render ->
#     div onclick: 'clicked', ->
#       span 'Hello World {{c}}'

#   data: ->
#     c: 1

#   methods:
#     clicked: ->
#       @c++

#   compiled: ->
#     console.log @c
# )

# new Vue(
#   el: 'body'

#   template: render ->
#     tag 'my-component', c: 2
# )

# el = vm.$mount()
# console.log el
# document.body.appendChild(el.$el)


# ********** Trifl ***********

# trifl = require('trifl')
# trifl.expose window
# trifl.tagg.expose window

# v = view (newslist) ->
#   ul class: 'newslist', ->
#     style scoped: '', '.desc, .newslist {color: cyan;}',
#     newslist.forEach (news) ->
#       li key: news.id, ->
#         style scoped: '', '.desc {color: red;}',
#         a href: '/news/#{news.slugid}', news.title, onclick: ->
#           navigate '/news/#{news.slugid}'
#         span class: 'desc', news.description

# document.body.appendChild v.el
# v([
#   slugid: '2323'
#   title: 'It is real'
#   description: 'ksaldjlsjd klsjdkl saj dkljs alkd jsaj'
# ,
#   slugid: '0489'
#   title: 'It is fake'
#   description: 'jkd s-98uqw [jdjkdhasj hsd'
# ,
#   slugid: '2373'
#   title: 'It might be'
#   description: 'eioui dhjskldf asjkldhk hyuyoe'
# ])


# ********** Zorium ***********

# z = require('zorium')

# class HelloMessage
#   render: ({name}) ->
#     z 'div',
#       "Hello #{name}"

# z.render(document.body, z(new HelloMessage(), name: 'Zorium'))

# class Timer
#   constructor: ->
#     @state = z.state
#       secondsElapsed: 0
#       interval: null

#   onMount: =>
#     @state.set(interval: setInterval(=>
#       @state.set secondsElapsed: @state().secondsElapsed + 1
#     , 1000))

#   onBeforeUnmount: =>
#     clearInterval @state().interval

#   clicker: (el) =>
#     console.log "clicked"
#     @state.set secondsElapsed: @state().secondsElapsed + 10

#   render: =>
#     z 'link', href: 'http://fonts.googleapis.com/css?family=Roboto:400,300,500', rel='stylesheet', type='text/css'
#     z 'style', color: 'red'
#     z '.myclass#myid', style: {color: 'red'}, onclick: ( => @state.set secondsElapsed: @state().secondsElapsed + 10),
#       "Seconds Elapsed: #{@state().secondsElapsed}"

# z.render document.body, new Timer()
