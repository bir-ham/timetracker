jQuery -> 
  $("#invoices").dataTable
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#invoices').data('source')