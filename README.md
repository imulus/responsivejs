R.stops =
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
	
R.change (from, into) ->
	console.log "I am a function that executes when the browser goes from desktop into #{into}"	


$('.logo').click 
	R.when 'mobile', ->
		 do something
	 .when 'tablet', ->
		 do something_else
	 .when 'desktop', ->
	 	 do another_thing		 


$('.logo').media('mobile').click ->
	do something

	