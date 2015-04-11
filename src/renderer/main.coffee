window.York = {}

window._ = require('underscore-plus')

_.extend(_,
  uncapitalize: (str) ->
    return str[0].toLowerCase() + str.slice(1)
)

_.is = require('is')
_.extend(_, require('underscore-contrib'))
_.extend(_, require('starkjs-underscore'))
_.number = require('underscore.number')
_.array = require('underscore.array')
_.extend(_, require('underscore-db'))
_.db = require('lowdb')

York.remote = require('remote')
York.app = York.remote.require('app')
York.BrowserWindow = York.remote.require('browser-window')
York.fs = York.remote.require('fs')
York.path = York.remote.require('path')
York.appWindow = York.remote.getCurrentWindow()

# York.Hazel = require('../../hazel/dist/hazel.js')
York.Hazel = require('../../hazel/hazel.coffee')

# York.Kaffa = require('../../kaffa/dist/kaffa.js')
York.Kaffa = require('../../kaffa/kaffa.coffee')

York.$ = York.Hazel.$
York.hazel = York.Hazel.hazel
York.cson = require 'cson-parser'

console.log York, _

{ View } = require('./view.coffee')
York.View = View

{ DesktopView } = require('./views/desktop-view.coffee')

York.dirs = {}
York.dirs.home = York.app.getPath('home')
York.dirs.app = York.app.getPath('appData')
York.dirs.user = York.app.getPath('userData')
York.dirs.tmp = York.app.getPath('temp')
York.dirs.root = York.app.getPath('exe')

console.log "#{York.app.getName()} v#{York.app.getVersion()}"

York.desktop = new DesktopView()
el = document.createElement('desktop-view')
document.querySelector('body').appendChild(el)

York.appWindow.maximize()
York.appWindow.setResizable(false)

York.appWindow.on('close', (e) ->
  console.log 'closed'
)

York.fs.readFile(York.path.join(York.dirs.home, '.gitconfig'), (err, data) ->
  throw err if err?
  console.log data.toString()
)

# { $, hazel, renderable, span, div, text, input, label } = _.Hazel

# window.onbeforeunload = (e) ->
#   console.log 'I do not want to be closed'
#   return false

# window.onblur = (e) ->
#   console.log 'blur'

# window.onfocus = (e) ->
#   console.log 'focus'

# hazel 'baseElement',
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

#   methods:
#     method0: ->
#       console.log 'method0', @

#   events:
#     'click': (e) ->
#       console.log 'clicked base-element', @


# hazel 'myBaseElement',
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

#   methods:
#     method1: ->
#       console.log 'method1', @

#   events:
#     'click span': (e) ->
#       console.log 'clicked span for my-base-element', @
#       e.stop()


# hazel 'my element',
#   extends: 'baseElement'

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

#   methods:
#     method0: ->
#       console.log 'method0.1', @

#     method1: ->
#       console.log 'method1', @

#     method2: ->
#       console.log 'method2', @

#   events:
#     'click': null

#     'click span': (e) ->
#       console.log 'clicked span for my-element', @

#     'change #my-input': (e) ->
#       console.log 'changed', @value


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
