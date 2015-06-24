{ BaseView, Class, Plugin, expose, unexpose } = York

York.ButtonView = Class 'ButtonView',
  extends: BaseView

  layout:

    attributes: ['icon', 'color', 'disabled', 'on-click']

    template: ->
      # if _.isString @icon
        # icon_view icon: @icon
      # text_view @textContent


module.exports =

  load: ->
    # hazel 'button-view', York.ButtonView

  unload: ->
