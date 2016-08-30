jQuery -> 
  table = $("#invoices").dataTable
    dom: "<'row'<'col-sm-4'l><'col-sm-4 text-center'B><'col-sm-4'f>>tp",

    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#invoices').data('source')

    lengthMenu: [ [10, 25, 50, -1], [10, 25, 50, "All"] ]
    buttons: [
        {extend: 'excel', className: 'btn-sm'},
        {extend: 'csv', title: 'ExampleFile', className: 'btn-sm'},
        {extend: 'pdf', title: 'ExampleFile', className: 'btn-sm'},
        {extend: 'print', title: 'ExampleFile', className: 'btn-sm'}
    ]

    "columnDefs": [ {
      "targets": 'no-sort',
      "orderable": false,
    } ]  

 

