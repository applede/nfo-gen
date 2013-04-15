CurrentFiles = new Meteor.Collection("currentFiles")

Meteor.subscribe 'currentFiles'

@openDialog = ->
  Meteor.call 'refreshCurrentDirectory', (err, result) ->
    Session.set('showFolderDialog', true)

Template.page.showFolderDialog = ->
  return Session.get("showFolderDialog")

Template.folderDialog.events
  'click .cancel': ->
    Session.set("showFolderDialog", false)

Template.folderDialog.folders = ->
  return CurrentFiles.find()
