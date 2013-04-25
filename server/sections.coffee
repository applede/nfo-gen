Sections = new Meteor.Collection("sections")

@allSections = ->
  return Sections.find()

Meteor.publish 'sections', ->
  return allSections()
