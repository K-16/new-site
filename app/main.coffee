parts = [
	require './parts/main'
	require './parts/news'
	require './parts/photos'
]

root    = document.getElementsByTagName("main")[0]
nav     = document.getElementsByTagName("nav")[0]
navList = nav.children[1]

router = {}
for name, part of parts
	navList.innerHTML += "<li><a href='/#!/#{part.path}#{part.default}'>#{part.title}</a></li>"

	for route, resolver of part.routes
		router["/" + part.path + route] = resolver

console.log "Router:", router

m.route root, "/main/", router

window.onscroll = =>
	if window.scrollY > 0
		unless nav.classList.contains "shadowed"
			nav.classList.add "shadowed"
	else
		if nav.classList.contains "shadowed"
			nav.classList.remove "shadowed"


