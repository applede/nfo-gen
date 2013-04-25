# Files in folders

fs = Npm.require 'fs'

Videos = new Meteor.Collection('videos')

Meteor.publish 'videos', ->
  return Videos.find()

Meteor.methods
  scanSection: ->
    scanSections()

scanSections = ->
  sections = allSections().fetch()
  for s in sections
    if s.folders
      scanFolder(f) for f in s.folders

scanFolder = (path) ->
  if fs.statSync(path).isDirectory()
    files = fs.readdirSync(path)
    for f in files
      Videos.insert({ filename: f })
