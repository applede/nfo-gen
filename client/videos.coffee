Videos = new Meteor.Collection 'videos'

Deps.autorun ->
  Meteor.subscribe("videos", Session.get("sectionId"))

Template.videos.videos = ->
  Videos.find()

Template.videos.events
  'click .scrape': ->
    console.log this.path
    Meteor.call 'scrape', this.path, (err, result) ->
      console.log 'scrape result'
      # console.log result
      # $dom = $('<html>').html(result)
      # $('body').append($('body').children(), $dom)
      # console.log $('h1', $dom)