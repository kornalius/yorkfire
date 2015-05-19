r = require('remote')
a = r.require('app')
p = r.require('path')

PropertyAccessors = require 'property-accessors'

userPath = p.join(a.getPath('home'), 'Yorkfire')

# Hazel = require('../../hazel/dist/hazel.js')
Hazel = require('../../hazel/hazel.coffee')

# Kaffa = require('../../kaffa/dist/kaffa.js')
Kaffa = require('../../kaffa/kaffa.coffee')
{ Class } = Kaffa


if !window.$?
  window.$ = Hazel.$

if !window._?
  window._ = require('underscore-plus')

  _.extend _,
    uncapitalize: (str) ->
      return str[0].toLowerCase() + str.slice(1)

  _.is = require('is')
  _.extend(_, require('underscore-contrib'))
  _.extend(_, require('starkjs-underscore'))
  _.number = require('underscore.number')
  _.array = require('underscore.array')
  _.extend(_, require('underscore-db'))
  _.db = require('lowdb')

npm = require('npm')

if !window.York?
  window.York =
    remote: r
    app: a
    BrowserWindow: r.require('browser-window')
    appWindow: r.getCurrentWindow()
    dirs:
      home: a.getPath('home')
      app: a.getPath('appData')
      user: userPath
      tmp: a.getPath('temp')
      root: a.getPath('exe')
      module: p.dirname(module.filename)
      node_modules: p.join(userPath, 'node_modules')
      user_pkg: p.join(userPath, 'package.json')
    fs: r.require('fs-plus')
    path: p
    cson: require 'cson-parser'
    npm: npm
    buffer: r.require 'buffer'
    child_process: r.require 'child_process'
    events: r.require 'events'
    domain: r.require 'domain'
    http: r.require 'http'
    https: r.require 'https'
    os: r.require 'os'
    stream: r.require 'stream'
    tls: r.require 'tls'
    url: r.require 'url'
    vm: r.require 'vm'
    zlib: r.require 'zlib'
    util: r.require 'util'

  _.extend York,
    settings: require('./settings.coffee')
    plugins: require('./plugins.coffee')
  ,
    Hazel
  ,
    Kaffa


{ app, appWindow } = York


_exposeDef = (o, name, def) ->
  PropertyAccessors.includeInto(o)

  e = _.clone(def)
  if !o.__york?
    o.__york = {}
  if !o.__york.exposed?
    o.__york.exposed = {}
  o.__york.exposed[name] = e

  if e.fn?
    o::[name] = e.fn
    e._args = e.fn.arguments
  else
    o[name] = if e.value? then e.value else null
    if e.get? or e.set?
      o.accessor name,
        get: e.get if e.get?
        set: e.set if e.set?


_unexposeDef = (o, name) ->
  if o.__york?.exposed?
    e = o.__york.exposed[name]

    if e.fn?
      delete o::[name]
    else
      delete o[name]
      # if e.get? or e.set?
      #   o.accessor name,
      #     get: e.get if e.get?
      #     set: e.set if e.set?

    delete o.__york.exposed[name]

    if _.keys(o.__york.exposed).length == 0
      delete o.__york.exposed


York.expose = (o, name, def) ->
  if _.isObject(name)
    _exposeDef(o, k, v) for k, v of name
  else
    _exposeDef(o, name, def)


York.unexpose = (o, name) ->
  if _.isObject(name)
    _unexposeDef(o, k) for k of name
  else
    _unexposeDef(o, name)


# Make sure home Yorkfire directory exists
if !York.fs.existsSync(userPath)
  York.fs.mkdirSync(userPath)

console.log "Booting #{app.getName()} v#{app.getVersion()}..."
console.log "Root path: #{York.dirs.root}"
console.log "Module path: #{York.dirs.node_modules}"
console.log "Temp path: #{York.dirs.tmp}"
console.log "App path: #{York.dirs.app}"
console.log "User path: #{York.dirs.user}"
console.log "Home path: #{York.dirs.home}"

appWindow.maximize()
appWindow.setResizable(false)

app.on 'before-quit', ->
  York.settings.saveSync()
  York.plugins.unload()
  console.log "Shutting down Hazel..."
  York.shutHazel()
  console.log "Shutting down Kaffa..."
  York.shutKaffa()

York.settings.load (err) ->
  # York.plugins.install ['async'], (err) ->
  York.plugins.load()

  tx = York.t("  Testing  ")
  console.log tx.trim('l')

  $('desktop-view')[0].shadowRoot.appendChild($('<button-view color="red" on-click="York.plugins.unload(\'york-desktop\')">unload desktop</button-view>')[0])

  $('desktop-view')[0].shadowRoot.appendChild($('<button-view color="transparent-black" on-click="$(\'desktop-view\')[0].toggleSelect(); console.log(\'button clicked\'); event.stopPropagation();">toggle select</button-view>')[0])

  console.log York

  # York.settings.set 'test', 'something', true


# { $, hazel, BaseView, renderable, span, div, text, input, label } = York

# # window.onbeforeunload = (e) ->
# #   console.log 'I do not want to be closed'
# #   return false

# # window.onblur = (e) ->
# #   console.log 'blur'

# # window.onfocus = (e) ->
# #   console.log 'focus'

# BaseElement = Class 'BaseElement',
#   extends: BaseView

#   created: ->
#     console.log "BaseElement.constructor"
#     @super()

#   layout:

#     style: ->
#       ':host':
#         'display': 'inline-block'
#         'cursor': 'default'
#       'div':
#         'background-color': 'orange'
#         padding: '2px'

#     template: renderable (el) ->
#       div ->
#         span "component #{el.tagName}"

#   method0: ->
#     console.log 'method0', @

#   '@click': (e) ->
#     console.log 'clicked base-element', @


# MyBaseElement = Class 'MyBaseElement',
#   extends: BaseElement

#   created: ->
#     console.log "MyBaseElement.constructor"
#     @super()

#   layout:

#     style: ->
#       ':host':
#         'background-color': 'blue'
#         'color': 'white'
#         margin: '4px'
#         padding: '4px'

#     # template: renderable (el) ->
#     #   div ->
#     #     span "component #{el.tagName}"

#   method0: ->
#     @super()
#     console.log 'method0.1', @

#   method1: ->
#     console.log 'method1', @

#   '@click span': (e) ->
#     console.log 'clicked span for my-base-element', @
#     e.stop()


# MyElement = Class 'MyElement',
#   extends: MyBaseElement

#   created: ->
#     console.log "MyElement.constructor"
#     @super()

#   layout:

#     style: ->
#       ':host':
#         'background-color': 'red'
#         margin: '4px'
#         padding: '8px'
#         'border-radius': '4px'
#       '#my-input':
#         'margin': '4px 8px'
#         'background-color': 'yellow'

#     template: renderable (el) ->
#       div ->
#         div ->
#           input '#my-input.my-class', type: 'text', bind: 'inputValue'
#         div ->
#           input '#my-check.my-class', type: 'checkbox', bind: 'checkValue'
#           label 'Check'
#         div ->
#           text "#{el.$$?.myInput?.value}, #{el.inputValue}"
#         div ->
#           text "#{el.$$?.myCheck?.checked}, #{el.checkValue}"

#   attached: ->
#     @idValue = @querySelector(":root /deep/ #my-input")

#   $inputValue: 'something'

#   $checkValue: false

#   method0: ->
#     @super()
#     console.log 'method0.2', @

#   method1: ->
#     console.log 'method1', @

#   method2: ->
#     console.log 'method2', @

#   '@click': null

#   '@click span': (e) ->
#     console.log 'clicked span for my-element', @

#   '@change #my-input': (e) ->
#     console.log 'changed', @value


# hazel 'base-element', BaseElement
# hazel 'my-base-element', MyBaseElement
# hazel 'my-element', MyElement


# el = document.createElement('my-element')
# document.querySelector('body').appendChild(el)
# el.method0()
# el.method1()
# el.method2()

# el = document.createElement('my-base-element')
# document.querySelector('body').appendChild(el)
# el.method0()
# el.method1()

# el = document.createElement('base-element')
# document.querySelector('body').appendChild(el)
# el.method0()

# # console.log $('my-element, my-base-element, base-element')

# # console.log York.b(true)
