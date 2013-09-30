$(document).ready ->
  $(".tables").dataTable
    bPaginate: true
    bLengthChange: true
    bFilter: true
    bSort: true
    bInfo: true
    bAutoWidth: true
    oLanguage: {
      "sLengthMenu": "Mostrar _MENU_ arquivos por página",
      "sZeroRecords": "Desculpe - Nada encontrado",
      "sInfo": "Mostrando _START_ to _END_ of _TOTAL_ arquivos",
      "sInfoEmpty": "Mostrando 0 to 0 of 0 arquivos",
      "sInfoFiltered": "(filtrado de _MAX_ arquivos)",
      "sSearch": "Pesquisa:"
      "sNext": "Proximo"
    }