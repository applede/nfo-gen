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
  if sectionId
    Sections.update(sectionId, { $set: { 'name': name }})

@sectionName = ->
  sectionId = Session.get('currentSectionId')
  if sectionId
    sections = Sections.find(sectionId).fetch()
    if sections[0]
      return sections[0].name
    else
      return null

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
