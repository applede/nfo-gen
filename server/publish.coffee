fs = Npm.require 'fs'

Folders = new Meteor.Collection("folders")

Meteor.publish 'folders', () ->
  return Folders.find()

Meteor.methods
  currentDirectory: () ->
    console.log 'currentDirectory'
    return "."