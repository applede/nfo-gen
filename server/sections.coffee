Sections = new Meteor.Collection("sections")

@allSections = ->
  return Sections.find()

@sectionFor = (sectionId) ->
  return Sections.findOne(sectionId)

Meteor.publish 'sections', ->
  return allSections()
