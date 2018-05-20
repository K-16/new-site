console.log "pages"

pug = require 'pug'

pages = {
	achievments: { name: "Достижения",  route: "/achievments" }
	activity:    { name: "Мероприятия", route: "/activity"    }
	contacts:    { name: "Контакты",    route: "/contacts"    }
	education:   { name: "Учёба",       route: "/education"   }
	history:     { name: "История",     route: "/history"     }
	news:        { name: "Новости",     route: "/news"        }
	people:      { name: "Люди",        route: "/people"      }
	photos:      { name: "Фотографии",  route: "/photos"      }
}

# func = pug.compileFile "app/assets/template.pug"

# for name, page of pages
# 	rendered = func page
# 	fs.writeFileSync "app/assets/#{name}/index.html", rendered

class Generator
	brunchPlugin: true
	type: 'template'
	extension: 'pug'

	compileStatic: ({ data }) ->
		console.log "static"
		rendered = pug.compile(data)(pages["people"])
		return rendered

module.exports = Generator
