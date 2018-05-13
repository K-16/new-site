module.exports = do ->
	PART = "contacts"

	Contacts = 
		oninit: ->
			window.scrollTo 0, 0

		view: ->
			cont = m "div", [
				m "h1", "Контакты"

				m "p", [
					"Маргарита Михайловна Пономарева: +7-913-645-23-88, "
					m "a[href=mailto:programmers@rambler.ru]", "programmers@rambler.ru"
					m "br"
					"Автор сайта — "
					m "a[href=http://malyutinegor.github.io]", "Малютин Егор"
					". Также огромное спасибо "
					m "a[href=http://vk.com/upisfree]", "Сене Пугачу"
					" за прошлый сайт."
				]

				m "p", "Приглашаются дети с 7 до 15 лет вместе с родителями и приносят с собой:"

				m "ul.list", [
					m "li", "ручку и листочек бумаги;"
					m "li", "ксерокопию свидетельства о рождении или паспорта ребенка;"
					m "li", "медицинскую справку, что ребенок может заниматься на компьютере и участвовать в массовых и спортивных мероприятиях;"
					m "li", "паспорт родителя для заключения договора на обучение."
				]

				m "iframe.gmap", { src: "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2287.664774748698!2d73.32147641545068!3d55.01404105619184!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x43aafde390bc26cf%3A0xe049e699aedc8f10!2z0JHQntCjINCU0J4g0LPQvtGA0L7QtNCwINCe0LzRgdC60LAgItCT0L7RgNC-0LTRgdC60L7QuSDQlNCy0L7RgNC10YYg0LTQtdGC0YHQutC-0LPQviAo0Y7QvdC-0YjQtdGB0LrQvtCz0L4pINGC0LLQvtGA0YfQtdGB0YLQstCwIg!5e0!3m2!1sru!2sru!4v1526115836486", frameborder: 0, style: border: 0, allowfullscreen: true }

				m "div#vk-group", oncreate: =>
					VK.Widgets.Group "vk-group", { mode: 3, width: cont.dom.offsetWidth }, 1088622
			]

	return {
		title: "Контакты"
		path: "contacts"
		class: "contacts"
		default: "/"
		routes: {
			"/": Contacts
		}
	}
