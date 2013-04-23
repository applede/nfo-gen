Sections = new Meteor.Collection "sections"

sectionHandle = Meteor.subscribe 'sections', ->
  console.log 'hi'

addSection = ->
  Sections.insert { name: "untitled" }

@deleteSection = ->
  sectionId = Session.get('currentSectionId')
  if sectionId
    Sections.remove sectionId
    selectSection(null)

selectSection = (sectionId) ->
  Session.set('currentSectionId', sectionId)

@updateSection = (name) ->
  sectionId = Session.get('currentSectionId')
  Sections.update(sectionId, { $set: { 'name': name }}) if sectionId

currentSection = (property) ->
  sectionId = Session.get('currentSectionId')
  return null unless sectionId
  sections = Sections.find(sectionId).fetch()
  return null unless sections[0]
  return sections[0][property]

@sectionName = ->
  return currentSection('name')

@sectionFolders = ->
  return currentSection('folders')

@addFolderToSection = (path) ->
  sectionId = Session.get('currentSectionId')
  return unless sectionId
  folders = sectionFolders()
  if folders
    folders.push(path)
  else
    folders = [ path ]
  Sections.update(sectionId, { $set: { 'folders': folders }})

@deleteFolder = (path) ->
  sectionId = Session.get('currentSectionId')
  return unless sectionId
  folders = sectionFolders()
  return unless folders
  i = folders.indexOf(path)
  return if i < 0
  folders.splice(i, 1)
  Sections.update(sectionId, { $set: { 'folders': folders }})

Template.sections.events
  'click #addSection': ->
    addSection()
  'click .section': ->
    selectSection(this._id)

Template.sections.sections = ->
  Sections.find()

Template.sections.active = ->
  currentSectionId = Session.get('currentSectionId')
  if currentSectionId == this._id
    return 'active'
  return ''
