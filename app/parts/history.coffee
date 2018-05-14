module.exports = do ->
	PART = "history"

	History =
		onremove: ->
			window.scrollTo 0, 0
			document.body.scrollTo 0, 0

		oninit: ->
			document.title = "История | K-16"
			
		view: (vnode) ->
			m.trust appContent.history

	return {
		title: "История"
		path: "history"
		default: "/"
		routes: {
			"/": History
		}
	}
