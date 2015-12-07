$(document).on('ready',function(){
	$('.post').on('click',function(){
		p = $(this);
		if(p.is("[unread]"))
		{
			id = p.attr('data-id');
			$.ajax({
		    type: 'POST',
		    url: '/post/'+id+'/read'
			});
		}
	})
});