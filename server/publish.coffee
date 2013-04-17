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
    newDir = fs.realpathSync currentDir + '/' + path
    if fs.statSync(newDir).isDirectory()
      currentDir = newDir
      refreshCurrentDir()
    return currentDir
