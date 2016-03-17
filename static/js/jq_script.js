$(document).ready(function(){
	// Determine recent inbox span exists
	if ($('span.recent_inbox').length > 0) 
		$('span.recent_inbox').html(twemoji.parse('\uD83D\uDCE8') + $('span.recent_inbox').text());

});