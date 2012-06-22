	R.stops
		desktop : '(min-width: 980px)'
		tablet	: '(min-width: 480px) and (max-width: 979px)'
		mobile	: '(max-width: 480px)'


	R.is 'mobile' #=> bool
	R.isnt 'mobile' #=> bool

	R.when 'mobile', ->
		console.log "I am a function that only runs in mobile"

	R.into 'tablet', (from) ->
		console.log "I am a function that runs when the browser goes into tablet from #{from}"

	R.from 'desktop', (into) ->
		console.log "I am a function that runs when the browser goes from desktop into #{into}"
	
	R.change (into, from) ->
		console.log "I am a function that executes when the browser goes from desktop into #{into}"	

	R.from("desktop").into("tablet").into("mobile").exec ->
		console.log "I just came from desktop then tablet and now I'm in mobile"


	$('.logo').click 
		R.when ['mobile','tablet'], ->
			 do something
		 .when 'desktop', ->
		 	 do another_thing		 


	$('.logo').media('mobile').click ->
		do something

	