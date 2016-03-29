$(document).ready(function(){
	// Determine recent inbox li exists
	if ($('span.inbox_emoji').length > 0) {
		$('span.inbox_emoji').html(twemoji.parse('\uD83D\uDCE8')+'&nbsp;');
	}
    if ($('span.classroom_emoji').length > 0) {
		$('span.classroom_emoji').html(twemoji.parse('\uD83C\uDFEB')+'&nbsp;');
	}

	// errorlist style
	$('ul.errorlist li').html('&#x25BE; '+$('ul.errorlist li').html());

});

// $( "input[name='user_action']:checked" ).length