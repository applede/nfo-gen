Videos = new Meteor.Collection 'videos'

videoHandle = Meteor.subscribe 'videos'

Template.videos.videos = ->
	Videos.find()
