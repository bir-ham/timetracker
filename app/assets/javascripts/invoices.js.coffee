jQuery -> 
  $("#invoices").dataTable
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#products').data('source')