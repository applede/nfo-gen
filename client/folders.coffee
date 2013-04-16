Folders = new Meteor.Collection "folders"

folderHandle = Meteor.subscribe 'folders', ->
  console.log 'hi'

Template.folders.events
  'mouseup #addFolder': ->
    openDialog()
