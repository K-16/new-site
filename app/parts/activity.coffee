module.exports = do ->
	PART = "activity"

	i = 0
	NightMode =
		_event: ->
			sc = (window.scrollY or document.body.scrollTop or document.documentElement.scrollTop)
			elem = document.getElementById "nns"
			top = elem.offsetTop
			if sc >= top
				document.body.classList.add "dark"
			else
				document.body.classList.remove "dark"

		start: ->
			window.scrollEvents.add NightMode._event

		stop: ->
			window.scrollEvents.remove NightMode._event


	Activity = 
		oninit: ->
			document.title = "Мероприятия | K-16"

		oncreate: ->
			NightMode.start()

		onremove: ->
			window.scrollTo 0, 0
			document.body.scrollTo 0, 0
			NightMode.stop()

		view: ->
			m "div", [
				m.trust appContent.activity
			]

	return {
		title: "Мероприятия"
		path: "/activity"
		default: "/"
		routes: {
			"/": Activity
		}
	}
