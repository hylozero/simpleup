// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require jquery-fileupload
//= require dataTables/jquery.dataTables
//= require dataTables/bootstrap/2/jquery.dataTables.bootstrap
//= require_tree .

$(document).ready(function(){
	$('.table-hover.clicable td:not(:last-child)').click(function() {
    	window.location = $(this).parent().attr('id');
	});
});

$(document).ready(function(){
	if($('#directory_private:checked').length > 0) {
		$('#allowed-users-div').show();
	} else {
		$('#allowed-users-div').hide();			
	}

	$('#directory_private').change(function(){
		if(this.checked) {
			$('#allowed-users-div').show();
		} else {
			$('#allowed-users-div').hide();			
		}
	})
})

$(function() {
	$("dd").each(function() {
		if ($(this).html().length === 0) {
			$(this).css("color", "red");
			$(this).css("font-weight", "bold");
			$(this).html("#");
		} else {
			$("ul").each(function() {
				if ($(this).html().length === 0) {
					$(this).remove();
				}
			});
		}
	});
});