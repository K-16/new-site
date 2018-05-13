module.exports = do ->
	PART = "history"

	History =
		oninit: ->
			window.scrollTo 0, 0
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
