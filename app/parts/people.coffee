module.exports = do ->
	PART = "people"

	People =
		onremove: ->
			window.scrollTo 0, 0
			document.body.scrollTo 0, 0

		oninit: ->
			document.title = "Люди | K-16"

		view: ->
			m.trust appContent.people

	return {
		title: "Люди"
		path: "/people"
		default: "/"
		routes: {
			"/": People
		}
	}
