Folders = new Meteor.Collection("folders")

Meteor.publish 'folders', ->
  return Folders.find()

# CurrentFiles dialog

fs = Npm.require 'fs'

CurrentFiles = new Meteor.Collection("currentFiles")

Meteor.publish 'currentFiles', ->
  return CurrentFiles.find()

Meteor.methods
  refreshCurrentDirectory: ->
    cwd = fs.realpathSync('.')
    console.log 'currentDirectory = ', cwd
    CurrentFiles.remove()
    CurrentFiles.insert { name: 'xxx' }
    return cwd
