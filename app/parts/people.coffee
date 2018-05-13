module.exports = do ->
	PART = "people"

	People =
		oninit: ->
			window.scrollTo 0, 0
			document.title = "Люди | K-16"

		view: ->
			m.trust appContent.people

	return {
		title: "Люди"
		path: "people"
		default: "/"
		routes: {
			"/": People
		}
	}
