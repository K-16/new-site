module.exports = do ->
	PART = "main"

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

		bind: (vnode) ->
			for photo in @photos
				vnode.dom.innerHTML += "<img src=#{photo.src}>"

			$(vnode.dom).slick {
				infinite: true
				speed: 300
				autoplay: true
				autoplaySpeed: 3000
				slidesToShow: 1
				adaptiveHeight: true
				pauseOnHover: true
			}

		view: ->
			if @photos.length > 0
				m "div.slick-ul-list-container",
					m "ul.slick-ul-list", { oncreate: (vnode) => Slider.bind.call @, vnode }
			else
				m "div.preloader",
					m "img[src=/img/preloader.svg]"


	Main =
		view: ->
			m "div", [
				m "h1", "Главная"

				m "i", """Сайт коллектива детей 7–17 лет, педагогов, выпускников и родителей. Мы занимаемся программированием и WEB–конструированием."""

				m Slider

				m "p", """Творческая лаборатория «Проект К–16» выросла из кружка «Программист» Городского Дворца детского (юношеского) творчества города Омска (Красный путь, 155)."""

				m "p.why-k16", """Почему К–16? Потому, что мы находимся в кабинете 16 Городского Дворца детского (юношеского) творчества."""

				m "p", """Почему творческая лаборатория — это понятно. Мы разрабатываем программы, изучаем новые технологии для работы в Интернете, рисуем и участвуем в различных проектах.

		На страницах сайта можно узнать об истории, об образовательной программе, реализуемой в творческой лаборатории, о наших достижениях, праздниках, детях, педагогах, выпускниках.

		Этот сайт был сделан «ручками», без помощи готовых движков, потому что мы придерживаемся мнения Дуванова Александра Александровича, руководителя Роботландского университета:"""
				
				m "q", """Надо потихоньку со школы учить тех, кто будет в состоянии писать готовые движки, выбрав соответствующую профессию. Ведь изготовление сайта на движке практически не дает настоящего представления об этой профессии. Если в школе учить только пользоваться программами, и не учить программировать, то как ребятам узнать, что программирование — это их призвание?"""
			]

	return {
		"/": Main
	}