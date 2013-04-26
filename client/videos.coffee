Videos = new Meteor.Collection 'videos'

Deps.autorun ->
  Meteor.subscribe("videos", Session.get("sectionId"))

Template.videos.videos = ->
	Videos.find()

Template.videos.events
  'click .scrape': ->
    Meteor.http.get 'http://javcloud.us/?s=adz-136&submit=Search', (err, result) ->
      console.log result.content