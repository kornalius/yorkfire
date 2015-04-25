sysPath = ->
  require('path').join(York.dirs.module, 'settings.cson')

userPath = ->
  require('path').join(York.dirs.user, 'settings.cson')

module.exports =

  load: (cb) ->
    { fs, path, cson } = York
    York.settings.system = {}

    console.log "Loading settings..."
    console.log "  system"
    fs.readFile sysPath(), (err, data) ->
      if !err?
        if data.length
          York.settings.system = cson.parse(data)
        else
          York.settings.system = {}

        console.log "  user"
        fs.readFile userPath(), (err, data) ->
          if !err?
            if data.length
              York.settings.user = cson.parse(data)
            else
              York.settings.user = {}
          else
            throw err
          cb(err) if cb?
      else
        throw err
        cb(err) if cb?

  save: (cb) ->
    { cson } = York
    console.log "Saving settings..."
    console.log "  user"
    require('fs').writeFile userPath(), cson.stringify(York.settings.user, null, 2), (err) ->
      cb(err) if cb?

  saveSync: ->
    { cson } = York
    console.log "Saving settings (sync)..."
    console.log "  user"
    require('fs').writeFileSync userPath(), cson.stringify(York.settings.user, null, 2)

  set: (key, value, autosave=false) ->
    _.setValueForKeyPath York.settings.user, key, value
    if autosave
      @save()

  get: (key, defaultValue) ->
    _.valueForKeyPath _.extend({}, York.settings.system, York.settings.user), key

