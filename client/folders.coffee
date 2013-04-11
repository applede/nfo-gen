Folders = new Meteor.Collection "folders"

folderHandle = Meteor.subscribe 'folders', () ->
  console.log 'hi'

Template.lists.events
  'mouseup #addFolder': () ->
    Session.set('showFolderDialog', true)

Template.page.showFolderDialog = () ->
  return Session.get("showFolderDialog")

Template.folderDialog.events
  'click .cancel': () ->
    Session.set("showFolderDialog", false)

Template.folderDialog.folders = () ->
  curDir = Meteor.call 'currentDirectory', (err, result) ->
    console.log result
  return Folders.find()
