CurrentFiles = new Meteor.Collection("currentFiles")

Meteor.subscribe 'currentFiles'

@openDialog = ->
  Meteor.call 'refreshCurrentDirectory', (err, result) ->
    console.log 'refresh'
    $("#chooseFolder").modal 'show'

Template.folderDialog.folders = ->
  return CurrentFiles.find()
