r = require('remote')
a = r.require('app')
p = r.require('path')

userPath = p.join(a.getPath('userData'), 'user')

# Hazel = require('../../hazel/dist/hazel.js')
Hazel = require('../../hazel/hazel.coffee')

# Kaffa = require('../../kaffa/dist/kaffa.js')
Kaffa = require('../../kaffa/kaffa.coffee')

if !window.$?
  window.$ = require('cash-dom')

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

  require('./view.coffee')

console.log York

{ app, appWindow } = York

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
  console.log 'before-quit'
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

  $('desktop-view')[0].shadowRoot.appendChild($('<button onclick="York.plugins.unload(\'york-desktop\')">unload desktop</button>')[0])

  console.log York

  # York.settings.set 'test', 'something', true


# { $, hazel, renderable, span, div, text, input, label } = York

# window.onbeforeunload = (e) ->
#   console.log 'I do not want to be closed'
#   return false

# window.onblur = (e) ->
#   console.log 'blur'

# window.onfocus = (e) ->
#   console.log 'focus'

# hazel 'base-element',
#   style:
#     ':host':
#       'display': 'inline-block'
#       'cursor': 'default'
#     'div':
#       'background-color': 'orange'
#       padding: '2px'

#   template: renderable (el, content) ->
#     div ->
#       if content?
#         content(el)
#       else
#         span "component #{el.tagName}"

#   method0: ->
#     console.log 'method0', @

#   '@click': (e) ->
#     console.log 'clicked base-element', @


# hazel 'my-base-element',
#   extends: 'base-element'

#   style:
#     ':host':
#       'background-color': 'blue'
#       'color': 'white'
#       margin: '4px'
#       padding: '4px'

#   template: renderable (el) ->
#     div ->
#       span "component #{el.tagName}"

#   method0: ->
#     @super()
#     console.log 'method0.1', @

#   method1: ->
#     console.log 'method1', @

#   '@click span': (e) ->
#     console.log 'clicked span for my-base-element', @
#     e.stop()


# hazel 'my-element',
#   extends: 'my-base-element'

#   style:
#     ':host':
#       'background-color': 'red'
#       margin: '4px'
#       padding: '8px'
#       'border-radius': '4px'
#     '#my-input':
#       'margin': '4px 8px'
#       'background-color': 'yellow'

#   data:
#     inputValue: 'something'
#     checkValue: false

#   attached: ->
#     @data 'idValue', @querySelector(":root /deep/ #my-input")

#   template: renderable (el) ->
#     div ->
#       input '#my-input.my-class', type: 'text', bind: 'inputValue'
#     div ->
#       input '#my-check.my-class', type: 'checkbox', bind: 'checkValue'
#       label 'Check'
#     div ->
#       text "#{el.data('$.myInput')?.value}, #{el.data 'inputValue'}"
#     div ->
#       text "#{el.data('$.myCheck')?.checked}, #{el.data 'checkValue'}"

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


# el = document.createElement('my-element')
# document.querySelector('body').appendChild(el)
# el.method0()

# el = document.createElement('my-base-element')
# document.querySelector('body').appendChild(el)
# el.method0()

# el = document.createElement('base-element')
# document.querySelector('body').appendChild(el)
# el.method0()

# # console.log $('my-element, my-base-element, base-element')
