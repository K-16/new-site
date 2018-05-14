module.exports = do ->
	PART = "activity"

	Activity = 
		onremove: ->
			window.scrollTo 0, 0
			document.body.scrollTo 0, 0

		oninit: ->
			document.title = "Мероприятия | K-16"

		view: ->
			m.trust appContent.activity

	return {
		title: "Мероприятия"
		path: "activity"
		default: "/"
		routes: {
			"/": Activity
		}
	}
