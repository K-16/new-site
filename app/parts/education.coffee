module.exports = do ->
	PART = "education"

	Education = 
		oninit: ->
			window.scrollTo 0, 0
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
