Template.lists.events
  'mouseup #addFolder': () ->
    console.log 'up'
    Session.set('opened', true)

Template.folder_chooser.opened = () ->
  console.log 'opened'
  return if Session.get('opened') then 'opened' else 'closed'
