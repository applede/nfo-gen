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

Template.chooseFolderDialog.show = ->
  return Session.get 'showChooseDialog'

Template.chooseFolderDialog.folders = ->
  return CurrentFiles.find()

Template.chooseFolderDialog.currentDirectory = ->
  return Session.get 'currentDir'

Template.chooseFolderDialog.events
  'click .cancel': ->
    closeDialog()

  'click .ok': ->
    closeDialog()
    callback(Session.get('currentDir')) if callback
 
  'click .fileitem': (event) ->
    console.log event.target.innerHTML
    changeDirectory event.target.innerHTML
