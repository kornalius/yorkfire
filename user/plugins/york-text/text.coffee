{ Text, t, hazel, BaseView, TerminalView, Class, Plugin, expose, unexpose, loadCSS, dirs, path, theme, renderable, div } = York
{ important, none, auto, inherit, absolute, middle, baseline, relative, left, solid, transparent, rgba, em, rem, px } = York.css
TextBuffer = require('./buffer.coffee')


York.TextView = Class 'TextView',
  extends: TerminalView

  layout:

    attributes: []


  created: ->
    @super()

    @text = new TextBuffer('')


  test1: ->
    that = @
    s = ''
    for i in [0..1]
      s += 'Lorem ipsum Anim non fugiat est occaecat sit deserunt Duis proident exercitation Duis fugiat veniam est labore amet\n velit ut dolore nulla est non sit veniam fugiat nulla sint dolor exercitation occaecat aliquip deserunt dolore Duis ea enim\n Ut proident tempor ullamco deserunt quis anim nostrud commodo in deserunt esse do laboris cupidatat nostrud Excepteur in\n qui dolor officia magna cillum laborum exercitation pariatur Excepteur Excepteur adipisicing non anim veniam do occaecat\n eiusmod in officia Duis mollit minim aliqua nulla eu enim exercitation dolor sint ea ullamco veniam mollit consectetur\n cillum irure laborum dolor eu dolore nulla consequat nostrud consectetur ex qui enim anim proident adipisicing voluptate ut\n non ullamco elit voluptate dolore ad ad minim minim qui in qui nostrud velit est commodo et tempor tempor Duis in\n cupidatat id dolore Ut sint non anim mollit velit sint eu non occaecat mollit qui velit reprehenderit irure laborum sint\n sed officia sed cillum aliqua dolore fugiat cupidatat in anim ea magna ut irure consequat irure laborum aliquip anim magna\n cillum ea sit.\n'
    @text.text(s, ->
        that.text.logLines()
        console.log("")
        that.text.text(40, "NEWLY INSERTED\nDUMMY TEXT", ->
          that.text.logLines()
        )
    )


module.exports =

  load: ->
    hazel 'text-view', York.TextView

  unload: ->

