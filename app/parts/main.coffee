module.exports = do ->
	PART = "main"

	ImageSlider = 
		bind: (vnode) ->
			$(vnode.dom).slick {
				lazyLoad: 'progressive'
				variableWidth: true
				adaptiveHeight: true
				pauseOnHover: true
				centerMode: true
			}	

		view: (vnode) ->
			m "div", { oncreate: (vnode) => ImageSlider.bind.call @, vnode }, vnode.attrs.images.map (image) ->
				m "div",
					m "img", { "data-lazy": image.src }

	SliderModel =
		oninit: ->
			@photos = []
			m.jsonp
				url: "https://api.vk.com/method/photos.get"
				data:
					owner_id: -1088622
					album_id: 219881429
					v: "5.74"

			.then ({ response }) =>
				@photos = response.items.map (photo) ->
					# pick some quality
					photo.src = photo.photo_807 or photo.photo_604 or photo.photo_130 or photo.photo_75
					return photo

	Slider =
		oninit: SliderModel.oninit

		view: ->
			if @photos.length > 0
				m ImageSlider, { images: @photos }	
			else
				m "div.preloader",
					m "img[src=/img/preloader.svg]"


	Main =
		oninit: ->
			window.scrollTo 0, 0
			document.title = "Главная | K-16"

		view: ->
			m "div", [
				m.trust appContent.beforeSlider	

				m Slider

				m.trust appContent.afterSlider
			]

	return {
		title: "Главная"
		path: "main"
		default: "/"
		routes: {
			"/": Main
		}
	}