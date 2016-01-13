(($) ->
	timestr = (t) ->
		digits = (x, n, c) ->
			c = if c then c else '0'
			x = '' + Math.floor( x)
			x = c + x  while n > x.length
			x
		"#{digits(t/3600,2,'0')}:#{digits((t/60)%60,2,'0')}:#{digits(t%60,2,'0')}"

	strtime = (t) ->
		if t and t = t.match /^(\d?\d):(\d\d):(\d\d)$/
			3600*Math.floor( t[1])+60*Math.floor( t[2])+Math.floor( t[3])

	netcastscroll = (a = $('#netcast')) ->
		if a.is( '*') and (t = location.hash.match( /^#(\d?\d:\d\d:\d\d)$/))
			a[0].currentTime = strtime t[1]
		undefined

	$ ->
		$(window).on 'hashchange', ->
			a = $ '#netcast'
			if a.is '*'
				netcastscroll a
				a[0].play()
			undefined
		netcastscroll()

		$('nc-ts').replaceWith ->
			$this = $ this
			ts = $this.text()
			$ '<a>'
			.text ts
			.attr
				class: $this.attr( 'class'),
				href: "\##{ts}", 'netcast-timestamp': strtime(ts)

		$('#netcast').on 'timeupdate', (e) ->
			ts = @currentTime
			cel = [-1]
			for el in $ '[netcast-timestamp]'
				el = $ el
				pcts = parseInt el.attr( 'netcast-timestamp')
				cel = [pcts, el]  if cel[0] < pcts and pcts <= ts
			if cel[1] and not cel[1].is( '.netcast-current')
				$('.netcast-current[netcast-timestamp]').removeClass 'netcast-current'
				cel[1].addClass 'netcast-current'
			undefined

		undefined
)(jQuery)
