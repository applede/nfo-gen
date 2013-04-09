Template.lists.events
  'mouseup #addFolder': () ->
    console.log 'up'
    Session.set('showFolderDialog', true)

Template.page.showFolderDialog = () ->
  return Session.get("showFolderDialog")

Template.folderDialog.events
  'click .cancel': () ->
    Session.set("showFolderDialog", false)

Template.folderDialog.folders = () ->
  return [ { name: "a" }, { name: "b"}]
