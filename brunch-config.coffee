exports.files =
	javascripts: joinTo: "app.js"
	stylesheets: joinTo: "main.css"

exports.plugins =
	coffeescript:
		bare: yes

	babel:
		presets: [ "env" ]

	on: [ "uglify-js-brunch", "clean-css-brunch" ]
