Scrapers = new Meteor.Collection "scrapers"

Meteor.subscribe 'scrapers'

@scrapers = ->
  return Scrapers.find {}