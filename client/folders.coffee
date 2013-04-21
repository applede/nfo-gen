Folders = new Meteor.Collection "folders"

folderHandle = Meteor.subscribe 'folders', ->
  console.log 'hi'

@addFolder = (path) ->
  Folders.insert { name: path }

@deleteSection = ->
  section = Session.get('currentSection')
  if section
    Folders.remove section._id
    selectSection(null)

selectSection = (section) ->
  Session.set('currentSection', section)

Template.folders.events
  'click #addFolder': ->
    openDialog()
  'click .section': ->
    selectSection(this)

Template.folders.folders = ->
  Folders.find()
