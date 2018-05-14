module.exports = do ->
	PART = "education"

	Education = 
		onremove: ->
			window.scrollTo 0, 0
			document.body.scrollTo 0, 0

		oninit: ->
			document.title = "Учёба | K-16"
				
		view: ->
			m.trust appContent.education

	return {
		title: "Учёба"
		path: "education"
		default: "/"
		routes: {
			"/": Education
		}
	}
