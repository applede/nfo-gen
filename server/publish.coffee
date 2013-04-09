Folders = new Meteor.Collection("folders")

Meteor.publish 'folders', () ->
  list_id = Folders.insert({name: "x"})
  return Folders.find()
