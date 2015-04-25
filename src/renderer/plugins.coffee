York.loadedPlugins = []

packages = ->
  initPackageJson()
  pkg = JSON.parse(York.fs.readFileSync(York.dirs.user_pkg))
  r = if pkg? and pkg.dependencies? then pkg.dependencies else {}
  nr = []
  for n, v of r
    pn = York.path.join(York.dirs.user, v)
    fn = York.path.join(pn, n)
    nr.push
      name: n
      version: if York.fs.existsSync(fn) then '0.0.0' else v
      location: if York.fs.existsSync(fn) then pn else York.path.join(York.dirs.node_modules, n)
  return nr

plugins = (type) ->
  r = []
  if !type?
    for k, v of York.settings.get('plugins')
      r.push k
  else if type == 'e'
    for k, v of York.settings.get('plugins')
      if v
        r.push k
  else if type == 'd'
    for k, v of York.settings.get('plugins')
      if !v
        r.push k
  return r

findPackage = (name) ->
  for p in packages()
    if p.name == name
      return p
  return { name: null, plugin: false, version: null }

packagePath = (name) ->
  { name, version, location } = findPackage(name)
  if name? then York.path.join(location, name)

packageFile = (name) ->
  York.path.join(packagePath(name), 'package.json')

packageJson = (name) ->
  JSON.parse(York.fs.readFileSync(packageFile(name)))

mainPackageFile = (name) ->
  York.path.join(packagePath(name), packageJson(name).main)

initPackageJson = ->
  { fs } = York
  f = York.dirs.user_pkg
  if !fs.existsSync(f)
    fs.writeFileSync f, JSON.stringify(
      name: "my_yorkfire_setup"
      private: true
      dependencies: {}
    , null, '  ')

install = (names, cb) ->
  { npm } = York
  initPackageJson()
  if !names?
    names = []
  npm.load
    prefix: York.dirs.user
    save: true
  , ->
    npm.commands.install names, (err) ->
      throw err if err?
      cb(arguments) if cb?

uninstall = (names, cb) ->
  { npm, settings } = York
  initPackageJson()
  npm.load
    prefix: York.dirs.user
    save: true
  , ->
    npm.commands.uninstall names, (err) ->
      throw err if err?
      for n in names
        unload(n)
      cb(arguments) if cb?

installed = (name) ->
  findPackage(name).name?

loaded = (name) ->
  for p in York.loadedPlugins
    if p.name == name
      return p
  return null

load = (name, spaces) ->
  if name?
    if !spaces?
      spaces = ''
    if !loaded(name)
      if installed(name)
        m = require(mainPackageFile(name))
        if m?
          console.log "#{spaces}#{name} loaded"
          York.loadedPlugins.push
            module: m
            name: name
          m.load()
      else
        console.log "#{spaces}#{name} ** not installed"
    else
      console.log "#{spaces}#{name} ** already loaded"
  else
    console.log "Loading plugins..."
    for n in plugins('e')
      load(n, '  ')

  # paths = fs.listSync path.join(York.dirs.module, 'plugins'), ['coffee', 'js']
  # if paths?
  #   for f in paths
  #     p = new Plugin f, ->
  #       console.log "  #{p.name}#{if p.ignored then ' -- ignored --' else ''}"

unload = (name, spaces) ->
  if name?
    if !spaces?
      spaces = ''
    p = loaded(name)
    if p?
      console.log "#{spaces}#{name} unloaded"
      p.module.unload()
      _.remove(York.loadedPlugins, p)
    else
      console.log "#{spaces}#{name} ** not loaded"
  else
    console.log "Unloading plugins..."
    for p in York.loadedPlugins
      unload(p.name, '  ')

publish = (name) ->

create = (opts) ->
  { fs } = York
  fn = "york-#{opts.name}"
  p = packagePath(fn)
  fs.mkdirSync(p)
  if !opts.main?
    opts.main = 'main.coffee'
  fs.writeFileSync packageFile(fn), JSON.stringify(opts, null, '  ')
  fs.writeFileSync mainPackageFile(fn), ''

module.exports =

  packages: packages
  findPackage: findPackage
  packagePath: packagePath
  packageFile: packageFile
  packageJson: packageJson
  initPackageJson: initPackageJson
  install: install
  uninstall: uninstall
  installed: installed
  loaded: loaded
  load: load
  unload: unload
  publish: publish
  create: create
  plugins: plugins

