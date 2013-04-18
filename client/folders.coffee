@Folders = new Meteor.Collection "folders"

folderHandle = Meteor.subscribe 'folders', ->
  console.log 'hi'

Template.folders.events
  'click #addFolder': ->
    openDialog()

Template.folders.folders = ->
  Folders.find()
