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

	// 
	$('section.info_list form a.delete').click(function(){
		$('section.info_list form').attr('method', 'POST');
		$('section.info_list form').attr('action', $('section.info_list form a.delete').attr('href'));
		$('section.info_list form a.delete').attr('href', '#')
		$('section.info_list form').submit();
		return false;
	});

	$('section.info_list form input.bottom_btn').click(function(){
		$('section.info_list form').attr('method', 'POST');
		$('section.info_list form').attr('action', $(location).attr('href'));
		$('section.info_list form').submit();
		return false;
	});
});
