{ loadCSS, path } = York

module.exports =

  load: ->
    loadCSS(path.join(__dirname, 'flex.css'))


  unload: ->
