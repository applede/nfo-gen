activateInput = (input) ->
  input.focus()
  input.select()

okCancelEvents = (selector, callbacks) ->
  ok = callbacks.ok or () -> {}
  cancel = callbacks.cancel or () -> {}

  events = {}
  events['keyup '+selector+', keydown '+selector+', focusout '+selector] =
    (evt) ->
      if evt.type == "keydown" and evt.which == 27
        # escape = cancel
        cancel.call(this, evt)
      else if evt.type == "keyup" and evt.which == 13 ||
              evt.type == "focusout"
        # blur/return/enter = ok/submit if non-empty
        value = String(evt.target.value or "")
        if value
          ok.call(this, value, evt)
        else
          cancel.call(this, evt)
  return events

Template.details.editing = ->
  return Session.get('editing')

Template.details.helpers
  name: ->
    return sectionName()

Template.details.events
  'click .delete': ->
    deleteSection()

  'dblclick #section-name, click .edit-section-name': (evt, tmpl) ->
    Session.set('editing', true)
    Deps.flush()
    activateInput(tmpl.find("#section-name-input"))

Template.details.events(okCancelEvents(
  '#section-name-input',
  ok: (text, evt) ->
    Session.set('editing', false)
    updateSection(text)
  cancel: ->
    Session.set('editing', false)
))
