$(document).ready(function(){
	// Determine recent inbox li exists
	if ($('span.inbox_emoji').length > 0) {
		$('span.inbox_emoji').html(twemoji.parse('\uD83D\uDCE8'));
	}

});