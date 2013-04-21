Template.details.helpers
  currentSection: ->
    return Session.get('currentSection')
  name: ->
    return Session.get('currentSection').name

Template.details.events
  'click .delete': ->
    deleteSection()
