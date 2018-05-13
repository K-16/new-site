module.exports = do ->
	PART = "activity"

	Activity = 
		oninit: ->
			window.scrollTo 0, 0
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
