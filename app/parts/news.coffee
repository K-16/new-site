module.exports = do ->
	PART = "news"

	idCount = 0

	News =
		onremove: ->
			window.scrollTo 0, 0
			document.body.scrollTo 0, 0

		oninit: ->
			document.title = "Новости | K-16"
			
			@id = "group-id-" + idCount
			idCount++

		view: ->
			cont = m "div.news-container",
				m "div.news", id: @id, oncreate: =>
					VK.Widgets.Group(@id, {mode: 4, wide: 1, width: cont.dom.offsetWidth, height: cont.dom.offsetHeight }, 1088622)

			m "div.news", [
				m "h1.news-title", "Новости"
				cont
			]

	return {
		title: "Новости"
		path: "/news"
		default: "/"
		routes: {
			"/": News
		}
	}
