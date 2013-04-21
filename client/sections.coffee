Sections = new Meteor.Collection "sections"

sectionHandle = Meteor.subscribe 'sections', ->
  console.log 'hi'

addSection = ->
  Sections.insert { name: "untitled" }

@deleteSection = ->
  section = Session.get('currentSection')
  if section
    Sections.remove section._id
    selectSection(null)

selectSection = (section) ->
  Session.set('currentSection', section)

Template.sections.events
  'click #addSection': ->
    addSection()
  'click .section': ->
    selectSection(this)

Template.sections.sections = ->
  Sections.find()
