CurrentFiles = new Meteor.Collection("currentFiles")

Meteor.subscribe 'currentFiles'

@openDialog = ->
  Meteor.call 'refreshCurrentDirectory', (err, result) ->
    Session.set 'currentDir', result
    $("#chooseFolder").modal 'show'

changeDirectory = (path) ->
  Meteor.call 'changeDirectory', path, (err, result) ->
    Session.set 'currentDir', result

Template.chooseFolderDialog.folders = ->
  return CurrentFiles.find()

Template.chooseFolderDialog.events
  'click .fileitem': (event) ->
    #Session.set 'currentDir', 'xxx'
    console.log event.target.innerHTML
    changeDirectory event.target.innerHTML

Template.chooseFolderDialog.currentDirectory = ->
  return Session.get 'currentDir'
