random = (min, max) ->
	min + Math.floor(Math.random() * (max - min))

# easter egg
actions = [
	-> console.log "h3110, h@k$$0r"
	-> console.log "Hello, World!"
	->
		if navigator.userAgent.match "win"
			console.log "format c: is very good and useful command"	
		else
			console.log "rm -rf / is very good and useful command"
]
actions[random(0, actions.length)]()

# some pages and todos
pages = {
	"/":            require './parts/main'
	"/news":        require './parts/news'
	"/history":     require './parts/history'
	"/education":   require './parts/education'
	"/activity":    require './parts/activity'
	"/people":      require './parts/people'
	"/achievments": require './parts/achievments'
	"/photos":      require './parts/photos'
	"/contacts":    require './parts/contacts'
}

root    = document.getElementsByTagName("main")[0]
nav     = document.getElementsByTagName("nav")[0]
navList = nav.children[1]

for name, page of pages
	navList.innerHTML += "<li><a href='/#{page.path}' onclick='openNav(\"#{page.path}\", event)'>#{page.title}</a></li>"

window.scrollEvents = new Set

lastScroll = window.scrollY or document.body.scrollTop or document.documentElement.scrollTop
setInterval ->
	# get scroll y
	sc = window.scrollY or document.body.scrollTop or document.documentElement.scrollTop

	if sc != lastScroll
		# if page isnt on top
		if (window.scrollY or document.body.scrollTop or document.documentElement.scrollTop) > 5
			nav.classList.add "shadowed"
		else
			nav.classList.remove "shadowed"

		window.scrollEvents.forEach (f) ->
			f()

		lastScroll = sc

, 100

burger = document.getElementsByClassName("burger-list")[0]
ul     = document.getElementsByClassName("list-nav")[0]

burger.onclick = ->
	ul.classList.toggle "showed"
	ul.classList.toggle "shadowed"
	for child in ul.children
		child.onclick = ->
			setTimeout ->
				ul.classList.toggle "showed"
				ul.classList.toggle "shadowed"
			, 40

window.openNav = (route, event) ->
	history.pushState { route }, "K-16", route
	page = pages[route]
	if page.default in ["/", ""]
		m.mount root, page.routes["/"] or page.routes[""]
	else
		m.route root, page.default, page.routes

	event.preventDefault()

# window.onpopstate = ({ state: { route } }) ->
# 	page = pages[route]
# 	if page.default in ["/", ""]
# 		m.mount root, page.routes["/"] or page.routes[""]
# 	else
# 		m.route root, page.default, page.routes

module.exports = (route) ->
	page = pages[route]
	if page.default in ["/", ""]
		m.mount root, page.routes["/"] or page.routes[""]
	else
		m.route root, page.default, page.routes
