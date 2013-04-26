Sections = new Meteor.Collection "sections"

sectionHandle = Meteor.subscribe 'sections', ->
  console.log 'hi'

addSection = ->
  Sections.insert { name: "untitled" }

@deleteSection = ->
  sectionId = Session.get('sectionId')
  if sectionId
    Sections.remove sectionId
    selectSection(null)

selectSection = (sectionId) ->
  Session.set('sectionId', sectionId)

@updateSection = (name) ->
  sectionId = Session.get('sectionId')
  Sections.update(sectionId, { $set: { 'name': name }}) if sectionId

currentSection = (property) ->
  sectionId = Session.get('sectionId')
  return null unless sectionId
  sections = Sections.find(sectionId).fetch()
  return null unless sections[0]
  return sections[0][property]

@sectionName = ->
  return currentSection('name')

@sectionFolders = ->
  return currentSection('folders')

@sectionScrapers = ->
  return currentSection('scrapers')

@addFolderToSection = (path) ->
  sectionId = Session.get('sectionId')
  return unless sectionId
  folders = sectionFolders()
  if folders
    folders.push(path)
  else
    folders = [ path ]
  Sections.update(sectionId, { $set: { 'folders': folders }})

@addScraperToSection = (scraper) ->
  sectionId = Session.get('sectionId')
  return unless sectionId
  scrapers = sectionScrapers()
  if scrapers
    scrapers.push(scraper)
  else
    scrapers = [ scraper ]
  Sections.update(sectionId, { $set: { 'scrapers': scrapers }})

@deleteFolder = (path) ->
  sectionId = Session.get('sectionId')
  return unless sectionId
  folders = sectionFolders()
  return unless folders
  i = folders.indexOf(path)
  return if i < 0
  folders.splice(i, 1)
  Sections.update(sectionId, { $set: { 'folders': folders }})

@deleteScraper = (scraper) ->
  sectionId = Session.get('sectionId')
  return unless sectionId
  scrapers = sectionScrapers()
  return unless scrapers
  i = scrapers.indexOf(scraper)
  return if i < 0
  scrapers.splice(i, 1)
  Sections.update(sectionId, { $set: { 'scrapers': scrapers }})

Template.sections.events
  'click #add-section': ->
    addSection()
  'click .section': ->
    selectSection(this._id)

Template.sections.sections = ->
  Sections.find()

Template.sections.active = ->
  sectionId = Session.get('sectionId')
  if sectionId == this._id
    return 'active'
  return ''
