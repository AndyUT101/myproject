$(document).ready(function(){
	// Determine recent inbox li exists
	if ($('span.inbox_emoji').length > 0) {
		$('span.inbox_emoji').html(twemoji.parse('\uD83D\uDCE8')+'&nbsp;');
	}
    if ($('span.classroom_emoji').length > 0) {
		$('span.classroom_emoji').html(twemoji.parse('\uD83C\uDFEB')+'&nbsp;');
	}

	// errorlist style
	if ($('ul.errorlist li').length > 0) {
		$('ul.errorlist li').prepend('&#x25BE; ');
	}

});

// $( "input[name='user_action']:checked" ).length