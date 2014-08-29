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
	$('.table-hover.clicable tr').click(function() {
    	window.location = $(this).attr('id');
	});
});

$(document).ready(function(){
  $(".datatable").dataTable({
    bProcessing: true,
    bServerSide: true,
    sDom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
    sPaginationType: "bootstrap",
    oLanguage: {
      sProcessing: "",
      sLengthMenu: "Mostrar _MENU_ registros por pagina",
      sZeroRecords: "Nenhum registro correspondente ao criterio encontrado",
      sInfoEmpty: "Exibindo 0 a 0 de 0 registros",
      sInfo: "Exibindo de _START_ a _END_ de _TOTAL_ registros",
      sInfoFiltered: "",
      sSearch: "Procurar: ",
      oPaginate: {
        sFirst: "Primeiro",
        sPrevious: "Anterior",
        sNext: "Próximo",
        sLast: "Último"
      }
    }
  });
})

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