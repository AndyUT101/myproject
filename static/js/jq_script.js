$(document).ready(function(){
	// Determine recent inbox li exists
	if ($('li.recent_inbox').length > 0) {
		var inbox_count = parseInt($('li.recent_inbox').text());
		$('li.recent_inbox').html(twemoji.parse('\uD83D\uDCE8') + inbox_count);
	}

});