Videos = new Meteor.Collection 'videos'

Deps.autorun ->
  Meteor.subscribe "videos", Session.get "sectionId"

Template.unscraped_videos.videos = ->
  Videos.find { scraped: false }

Template.unscraped_videos.scrapeDisabled = ->
  if Session.get 'scrapeDisabled'
    return 'disabled'
  else
    return ''

Template.unscraped_videos.events
  'click .scrape': ->
    return if Session.get 'scrapeDisabled'
    Session.set 'scrapeDisabled', true
    Meteor.call 'scrape', this._id, (err, result) ->
      Session.set 'scrapeDisabled', false
      # console.log result
      # $dom = $('<html>').html(result)
      # $('body').append($('body').children(), $dom)
      # console.log $('h1', $dom)

Template.scraped_videos.videos = ->
  Videos.find { scraped: true }
