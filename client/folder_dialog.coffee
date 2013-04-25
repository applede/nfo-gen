CurrentFiles = new Meteor.Collection("currentFiles")

Meteor.subscribe 'currentFiles'

callback = null

@openChooseFolderDialog = (cb) ->
  Meteor.call 'refreshCurrentDirectory', (err, result) ->
    Session.set 'currentDir', result
    callback = cb
    Session.set 'showChooseDialog', true

closeDialog = ->
  Session.set 'showChooseDialog', false

changeDirectory = (path) ->
  Meteor.call 'changeDirectory', path, (err, result) ->
    Session.set 'currentDir', result

Template.folder_dialog.show = ->
  return Session.get 'showChooseDialog'

Template.folder_dialog.folders = ->
  return CurrentFiles.find()

Template.folder_dialog.currentDirectory = ->
  return Session.get 'currentDir'

Template.folder_dialog.events
  'click .cancel': ->
    closeDialog()

  'click .ok': ->
    closeDialog()
    callback(Session.get('currentDir')) if callback
 
  'click .file-item': (event) ->
    changeDirectory event.target.innerHTML
