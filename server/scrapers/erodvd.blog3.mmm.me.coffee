info =
  name: 'Japanese AV (erodvd)'
  description: 'scrape from erodvd.blog3.mmm.me'
  scrape: scrape

Meteor.startup ->
  registerScraper info

scrape = ->
  console.log 'scrape'