{ color, BaseView, Class, Plugin, expose, unexpose } = York

York.CheckboxView = Class 'CheckboxView',
  extends: BaseView

  layout:

    attributes: ['color', 'checked', 'disabled', 'on-click']

    template: ->
      # text_view '.label', @textContent


  created: ->
    @super()
    @type = 'checkbox'


  # attached: ->
  #   @super()

  #   @on 'click', (e) ->
  #     el = e.currentTarget
  #     if !el.isDisabled()
  #       el.attr 'checked', el.attr('checked') != 'true'
  #       e.stopPropagation()


module.exports =

  load: ->
    # hazel 'checkbox-view', York.CheckboxView

  unload: ->
