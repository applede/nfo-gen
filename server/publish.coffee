Folders = new Meteor.Collection("folders")

Meteor.publish 'folders', ->
  return Folders.find()

# CurrentFiles dialog

fs = Npm.require 'fs'

CurrentFiles = new Meteor.Collection("currentFiles")

Meteor.publish 'currentFiles', ->
  return CurrentFiles.find()

currentDir = fs.realpathSync '.'

Meteor.methods
  refreshCurrentDirectory: ->
    CurrentFiles.remove {}
    files = fs.readdirSync currentDir
    files.push '..'
    files.sort()
    CurrentFiles.insert { name: filename } for filename in files
    return currentDir
