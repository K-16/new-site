module.exports = do ->
	PART = "news"

	idCount = 0

	News =
		oninit: ->
			@id = "group-id-" + idCount
			idCount++

		view: ->
			cont = m "div.news-container",
				m "div.news", id: @id, oncreate: =>
					VK.Widgets.Group(@id, {mode: 4, wide: 1, width: cont.dom.offsetWidth - 30, height: cont.dom.offsetHeight - 30}, 1088622)

			m "div.news", [
				m "h1.news-title", "Новости"
				cont
			]

	{
		"/": News
	}
