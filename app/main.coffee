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
pages = [
	require './parts/main'
	require './parts/news'
	require './parts/history'
	require './parts/education'
	require './parts/activity'
	require './parts/people'
	require './parts/contacts'
	require './parts/achievments'
	require './parts/photos'
]

root    = document.getElementsByTagName("main")[0]
nav     = document.getElementsByTagName("nav")[0]
navList = nav.children[1]

router = {}

for page in pages
	navList.innerHTML += "<li><a href='/#!/#{page.path}#{page.default}'>#{page.title}</a></li>"

	for route, resolver of page.routes
		router["/" + page.path + route] = resolver

console.log "Router:", router

m.route root, "/main/", router

lastScroll = window.scrollY or document.body.scrollTop or document.documentElement.scrollTop
setInterval ->
	# get scroll y
	sc = (window.scrollY or document.body.scrollTop or document.documentElement.scrollTop)

	if sc != lastScroll
		# if page isnt on top
		if (window.scrollY or document.body.scrollTop or document.documentElement.scrollTop) > 0
			unless nav.classList.contains "shadowed"
				nav.classList.add "shadowed"

		else
			if nav.classList.contains "shadowed"
				nav.classList.remove "shadowed"

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
