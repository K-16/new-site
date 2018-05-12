module.exports = do ->
	PART = "photos"

	avaliableYears = []
	avaliableNames = []

	##################
	##### PHOTOS #####
	##################

	nav = document.getElementsByTagName("nav")[0]

	PhotosViewer =
		bind: (vnode) ->
			lightGallery vnode.dom, { thumbnail: true }
			# open gallery
			vnode.dom.children[0]?.click()

		view: (vnode) ->
			# display images
			m "div.photos-viewer", { oncreate: PhotosViewer.bind }, vnode.attrs.photos.map (photo) ->
				m "a", { href: photo.src }, 
					m "img", { src: photo.src }

	##################
	##### ALBUMS #####
	##################

	AlbumsModel =
		load: ->
			# get albums from VK
			@loaded = false

			@albums = (await m.jsonp
				url: "https://api.vk.com/method/photos.getAlbums"
				data:
					owner_id: -1088622
					need_covers: true
					callback: "vkCallback"
					version: "5.74"
				callback: "vkCallback"
			).response

			# fill avaliableYears and avaliableNames and remove dates
			for album in @albums
				year = new Date(album.created * 1000).getFullYear()
				album.year = year
				unless year in avaliableYears
					avaliableYears.push year

				album.title = album.title.replace(/\|\s*\d*\s*/gi, "").trim()
				unless album.title in avaliableNames
					avaliableNames.push album.title

			@loaded = true

	Albums =
		oninit: AlbumsModel.load

		view: (vnode) ->
			return if not @loaded

			# filter albums
			if vnode.attrs.filter?
				filtered = @albums.filter vnode.attrs.filter
			else
				filtered = @albums

			m "div", [
				m "ul.albums", filtered.map (album) ->
					m "li.album", { onclick: => vnode.attrs.onclick album, key: album.aid }, [
						m "div.thumb",
							m "div.thumb-container",
								m "img.thumb-image", src: album.thumb_src
						m "br"
						m "span", vnode.attrs.title album
					]				
			]

	########################
	##### GALLERY #####
	########################

	GalleryModel =
		loadPhotos: (album) ->
			# get photos from VK
			@photos = []
			m.jsonp
				url: "https://api.vk.com/method/photos.get"
				data:
					owner_id: -1088622
					album_id: album.aid
					v: "5.74"

			.then ({ response }) =>
				@photos = response.items.map (photo) ->
					# pick some quality
					photo.src = photo.photo_807 or photo.photo_604 or photo.photo_130 or photo.photo_75
					return photo

	Gallery =
		oninit: ->
			window.scrollTo 0, 0			
			
		view: (vnode) ->
			m "div", [
				m "h1", "Фотографии"

				# sorting
				m "div.sort-method-container", [
					m "a.fas.fa-calendar-alt.sort-method[href=/" + PART + "/year/all/]", { class: (if vnode.attrs.year? then "checked"), oncreate: m.route.link }
					m "a.fas.fa-list-alt.sort-method[href=/" + PART + "/name/all/]", { class: (if vnode.attrs.name? then "checked"), oncreate: m.route.link }
				]

				m "br"

				# date links
				m "div.sort-link-container",
					if vnode.attrs.year?
						[
							m "a.sort-link", { class: (if vnode.attrs.year == "all" then "checked"), href: "/" + PART + "/year/all/", oncreate: m.route.link }, "Все"
							avaliableYears.map (year) ->
								m "a.sort-link", { class: (if parseInt(vnode.attrs.year) == year then "checked"), href: "/" + PART + "/year/" + year + "/", oncreate: m.route.link }, year
						]
					else if vnode.attrs.name?
						[
							m "a.sort-link", { class: (if vnode.attrs.name == "all" then "checked"), href: "/" + PART + "/name/all/", oncreate: m.route.link }, "Все"
							avaliableNames.map (name) ->
								m "a.sort-link", { class: (if vnode.attrs.name == name then "checked"), href: "/" + PART + "/name/" + name + "/", oncreate: m.route.link }, name
						]

				m Albums, {
					title:
						if vnode.attrs.year?
							(album) -> album.title
						else if vnode.attrs.name?
							(album) -> album.year

					onclick: (album) => GalleryModel.loadPhotos.call(@, album)

					filter:
						if vnode.attrs.year? and vnode.attrs.year != "all"
							(album) -> album.year == parseInt(vnode.attrs.year)
						else if vnode.attrs.name? and vnode.attrs.name != "all"
							(album) -> album.title == vnode.attrs.name
				}

				if @photos?.length > 0
					m PhotosViewer, photos: @photos
			]

	return {
		title: "Фотографии"
		path: "photos"
		default: "/year/all/"
		routes: {
			"/year/:year/": Gallery
			"/name/:name/": Gallery
		}
	}
