r = require('remote')
a = r.require('app')
p = r.require('path')

PropertyAccessors = require 'property-accessors'

userPath = p.join(a.getPath('home'), 'Yorkfire')

# Silverskin = require('../../silverskin/dist/silverskin.js')
Silverskin = require('../../silverskin/silverskin.coffee')

# Kaffa = require('../../kaffa/dist/kaffa.js')
Kaffa = require('../../kaffa/kaffa.coffee')
{ Class } = Kaffa

# Chicory = require('../../chicory/dist/chicory.js')
Chicory = require('../../chicory/chicory.coffee')


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

npm = require('npm')


_loadCSS = (path, macros) ->
  fs = require('fs')
  el = document.createElement('style')
  b = fs.readFileSync(path)
  if b?
    s = b.toString()
    if macros?
      for k, v of macros
        s = s.replace(new RegExp('__' + k + '__', 'gim'), v)
  else
    s = ''
  el.textContent = s
  document.querySelector('head').appendChild(el)
  return el


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
      components: './static/components'
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
    loadCSS: _loadCSS

  _.extend York,
    settings: require('./settings.coffee')
    plugins: require('./plugins.coffee')
  ,
    Silverskin
  ,
    Kaffa


# { fsdb } = Chicory

# fsdb.db.info().then((info) ->
#   console.log "fsdb:", info
# )

# fsdb.write('/My Documents/Alain Deschênes', { name: 'Alain Deschênes', age: 41, address: '8236 2nd avenue' }, (err, doc) ->
#   if !err
#     console.log doc
#     fsdb.write('/My Documents/Mélissa Dubé', { name: 'Mélissa Dubé', age: 36, address: '937 road st.' }, (err, doc) ->
#       if !err
#         console.log doc
#         fsdb.dir('/my documents/', (err, docs) ->
#           if !err
#             console.log docs
#           else
#             console.log err
#         )
#       else
#         console.log err
#     )
#   else
#     console.log err
# )


# i = 0
# while i++ < 100
#   fsdb.post(
#     name: 'Mittens'
#     occupation: 'kitten'
#     age: 3
#     hobbies: [
#       'playing with balls of yarn'
#       'chasing laser pointers'
#       'lookin\' hella cute'
#     ]
#   )
#   # .then((doc) ->
#   #   fsdb.get(doc.id).then((doc) ->
#   #     console.log doc
#   #   )
#   # )
#   .catch((err) ->
#     console.log err
#   )


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
  console.log "Shutting down Silverskin..."
  York.shutSilverSkin()
  console.log "Shutting down Kaffa..."
  York.shutKaffa()

York.settings.load (err) ->
  # York.plugins.install ['async'], (err) ->
  York.plugins.load()

  # tx = York.t("  Testing  ")
  # console.log tx.trim('l')

  console.log York

  # York.settings.set 'test', 'something', true

  Silverskin.test()