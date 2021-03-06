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

Template.details.folders = ->
  return {
    name: 'Folders'
    items: sectionFolders()
    add: ->
      openChooseFolderDialog((currentDir) -> addFolderToSection(currentDir))
    remove: (path) -> deleteFolder(path)
  }

Template.details.scrapers = ->
  return {
    name: 'Scrapers'
    items: sectionScrapers()
    add: -> openListDialog('Choose Scraper', scrapers(), 'Choose', (scraper) -> addScraperToSection(scraper))
    remove: (scraper) -> deleteScraper(scraper)
  }

Template.details.scanDisabled = ->
  if Session.get('scanDisabled')
    return 'disabled'
  else
    return ''

Template.details.events
  'click #delete-section': ->
    deleteSection()

  'dblclick #section-name, click #edit-section-name': (evt, tmpl) ->
    Session.set('editing', true)
    Deps.flush()
    activateInput(tmpl.find("#section-name-input"))

  'click .scan': ->
    return if Session.get('scanDisabled')
    Session.set('scanDisabled', true)
    Meteor.call 'scanSection', Session.get('sectionId'), (err, result) ->
      Session.set('scanDisabled', false)

Template.details.events(okCancelEvents(
  '#section-name-input',
  ok: (text, evt) ->
    Session.set('editing', false)
    updateSection(text)
  cancel: ->
    Session.set('editing', false)
))
