exports.paths =
	public: "public"

exports.files =
	javascripts: joinTo: "app.js"
	stylesheets: joinTo: "main.css"

exports.plugins =
	coffeescript:
		bare: yes

	babel:
		presets: [ "env" ]

# page generator

pug  = require "pug"
fs   = require "fs"
path = require "path"

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

exports.hooks =
	onCompile: (files, assets) ->
		setTimeout ->
			for asset in assets when asset.path.match "template.pug"
				console.log "Generating pages..."
				func = pug.compile asset.compiled
				for name, page of pages
					data = func page
					pth = path.join exports.paths.public, name, "index.html"
					fs.writeFileSync pth, data

				fs.unlinkSync asset.destinationPath

		, 100
