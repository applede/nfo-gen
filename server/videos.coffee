# Files in folders

fs = Npm.require 'fs'

Videos = new Meteor.Collection('videos')

Meteor.publish 'videos', (sectionId) ->
  return Videos.find({ sectionId: sectionId })

Meteor.methods
  scanSection: (sectionId) ->
    this.unblock()
    scanSections(sectionId)
    return true

  removeVideos: ->
    Videos.remove {}

scanSections = (sectionId) ->
  section = sectionFor(sectionId)
  if section.folders
    Videos.remove { sectionId: sectionId }
    scanFolder(sectionId, f) for f in section.folders

scanFolder = (sectionId, folder) ->
  if fs.statSync(folder).isDirectory()
    files = fs.readdirSync(folder)
    for f in files
      path = folder + '/' + f
      isFolder = fs.statSync(path).isDirectory()
      item = { sectionId: sectionId, path: path, folder: folder, filename: f, isFolder: isFolder }
      Videos.insert(item)
      scrape(item)
