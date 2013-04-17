Folders = new Meteor.Collection("folders")

Meteor.publish 'folders', ->
  return Folders.find()

# CurrentFiles dialog

fs = Npm.require 'fs'

CurrentFiles = new Meteor.Collection("currentFiles")

Meteor.publish 'currentFiles', ->
  return CurrentFiles.find()

currentDir = fs.realpathSync '.'

refreshCurrentDir = ->
  CurrentFiles.remove {}
  files = fs.readdirSync currentDir
  files.push '..'
  files.sort()
  CurrentFiles.insert { name: filename } for filename in files

Meteor.methods
  refreshCurrentDirectory: ->
    refreshCurrentDir()
    return currentDir
  changeDirectory: (path) ->
    currentDir = fs.realpathSync currentDir + '/' + path
    console.log 'currentDir', currentDir
    refreshCurrentDir()
    return currentDir
