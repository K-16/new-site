parts = {
	"main":   require './parts/main'
	"news":   require './parts/news'
	"photos": require './parts/photos'
}

root = document.getElementsByTagName("main")[0]
nav  = document.getElementsByTagName("nav")[0]

router = {}
for name, part of parts
	for route, resolver of part
		router["/" + name + route] = resolver

console.log "Router:", router

m.route root, "/main/", router

window.onscroll = =>
	if window.scrollY > 0
		unless nav.classList.contains "shadowed"
			nav.classList.add "shadowed"
	else
		if nav.classList.contains "shadowed"
			nav.classList.remove "shadowed"


