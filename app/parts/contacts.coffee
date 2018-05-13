module.exports = do ->
	PART = "contacts"

	Contacts = 
		oninit: ->
			window.scrollTo 0, 0
			document.title = "Контакты | K-16"

		view: ->
			m.trust appContent.contacts

	return {
		title: "Контакты"
		path: "contacts"
		default: "/"
		routes: {
			"/": Contacts
		}
	}
