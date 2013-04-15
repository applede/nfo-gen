Folders = new Meteor.Collection "folders"

folderHandle = Meteor.subscribe 'folders', () ->
  console.log 'hi'

Template.lists.events
  'mouseup #addFolder': () ->
    openDialog()
