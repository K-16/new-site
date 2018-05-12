module.exports = do ->
	PART = "achievments"

	avaliableYears = []
	avaliableCompetitions = []
	avaliableLevels = []

	sort = (arr) ->
		arr.sort (a, b) ->
			a < b

	addTo = (arr, item) ->
		unless arr.includes item
			arr.push item

	toUpper = (a) ->
		a[0].toUpperCase() + a.slice(1)

	##################
	##### PHOTOS #####
	##################

	ImageSlider =
		bind: (vnode, v) ->
			if @slicked
				$(vnode.dom.children[0]).slick "unslick"

			vnode.dom.children[0].innerHTML = ""

			v.attrs.images.map (image) ->
				if not v.attrs.filter or v.attrs.filter(image)
					vnode.dom.children[0].innerHTML += "<img data-lazy='#{image.src}'>"

			$(vnode.dom.children[0]).slick {
				lazyLoad: 'progressive'
				slidesToShow: 2
				variableWidth: true
				adaptiveHeight: true
				infinite: false
			}

			@slicked = true

		view: (vnode) ->
			m "div", { oncreate: ((vnode2) => ImageSlider.bind.call @, vnode2, vnode), onupdate: ((vnode2) => ImageSlider.bind.call @, vnode2, vnode) }, 
				m "div"

	########################
	##### GALLERY #####
	########################

	GalleryModel =
		oninit: (album) ->
			window.scrollTo 0, 0			

			# get photos from VK
			@photos = []
			m.jsonp
				url: "https://api.vk.com/method/photos.get"
				data:
					owner_id: -1088622
					album_id: 194971509
					v: "5.74"

			.then ({ response }) =>
				@photos = response.items.map (photo) ->
					# pick some quality
					photo.src = photo.photo_604 or photo.photo_130 or photo.photo_75

					prs = photo.text.split("\n")[0].split("|")

					photo.competition = toUpper prs[0].trim()
					photo.year        = parseInt prs[1].trim()
					photo.level       = toUpper prs[2].trim()

					if photo.level == "Всероссийский"
						photo.level = "Россия"

					addTo avaliableCompetitions, photo.competition
					addTo avaliableYears,        photo.year
					addTo avaliableLevels,       photo.level

					return photo

				sort avaliableCompetitions
				sort avaliableYears
				sort avaliableLevels

	Gallery =
		oninit: (vnode) ->
			window.scrollTo 0, 0			
			GalleryModel.oninit.call @, vnode
			
		view: (vnode) ->
			m "div", [
				m "h1", "Достижения"

				m "div.sort-method-container", [
					m "a.fas.fa-calendar-alt.sort-method[href=/" + PART + "/year/all/]", { class: (if vnode.attrs.year? then "checked"), oncreate: m.route.link }
					m "a.fas.fa-list-alt.sort-method[href=/" + PART + "/competition/all/]", { class: (if vnode.attrs.competition? then "checked"), oncreate: m.route.link }
					m "a.fas.fa-level-up-alt.sort-method[href=/" + PART + "/level/all/]", { class: (if vnode.attrs.level? then "checked"), oncreate: m.route.link }
				]

				m "br"

				m "div.sort-link-container",
					if vnode.attrs.year?
						[
							m "a.sort-link", { 
								class: (if vnode.attrs.year == "all" then "checked")
								href: "/" + PART + "/year/all/"
								oncreate: m.route.link
							}, "Все"
							avaliableYears.map (year) ->
								m "a.sort-link", { 
									class: (if parseInt(vnode.attrs.year) == year then "checked")
									href: "/" + PART + "/year/" + year + "/"
									oncreate: m.route.link
								}, year
						]
					else if vnode.attrs.competition?
						[
							m "a.sort-link", { 
								class: (if vnode.attrs.competition == "all" then "checked")
								href: "/" + PART + "/competition/all/"
								oncreate: m.route.link 
							}, "Все"
							avaliableCompetitions.map (competition) ->
								m "a.sort-link", { 
									class: (if vnode.attrs.competition == competition then "checked")
									href: "/" + PART + "/competition/" + competition + "/"
									oncreate: m.route.link
								}, competition
						]
					else if vnode.attrs.level?
						[
							m "a.sort-link", { 
								class: (if vnode.attrs.level == "all" then "checked")
								href: "/" + PART + "/level/all/"
								oncreate: m.route.link 
							}, "Все"
							avaliableLevels.map (level) ->
								m "a.sort-link", { 
									class: (if vnode.attrs.level == level then "checked")
									href: "/" + PART + "/level/" + level + "/"
									oncreate: m.route.link
								}, level
						]

				if @photos.length > 0
					m ImageSlider, {
						images: @photos

						filter: 
							if vnode.attrs.year? and vnode.attrs.year != "all"
								(photo) -> photo.year == parseInt vnode.attrs.year

							else if vnode.attrs.competition? and vnode.attrs.competition != "all"
								(photo) -> photo.competition == vnode.attrs.competition

							else if vnode.attrs.level? and vnode.attrs.level != "all"
								(photo) -> photo.level == vnode.attrs.level
					}
			]


	return {
		title: "Достижения"
		path: "achievments"
		default: "/year/all/"
		routes: {
			"/year/:year/":               Gallery
			"/competition/:competition/": Gallery
			"/level/:level/":             Gallery
		}
	}
