CurrentFiles = new Meteor.Collection("currentFiles")

Meteor.subscribe 'currentFiles'

@openDialog = ->
  Meteor.call 'refreshCurrentDirectory', (err, result) ->
    Session.set 'currentDir', result
    Session.set 'showChooseDialog', true

changeDirectory = (path) ->
  Meteor.call 'changeDirectory', path, (err, result) ->
    Session.set 'currentDir', result

Template.chooseFolderDialog.show = ->
  return Session.get 'showChooseDialog'

Template.chooseFolderDialog.folders = ->
  return CurrentFiles.find()

Template.chooseFolderDialog.events
  'click .cancel': ->
    Session.set 'showChooseDialog', false

  'click .fileitem': (event) ->
    console.log event.target.innerHTML
    changeDirectory event.target.innerHTML

Template.chooseFolderDialog.currentDirectory = ->
  return Session.get 'currentDir'
