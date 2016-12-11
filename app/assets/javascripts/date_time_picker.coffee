jQuery ->
  $('.form_datetime').datetimepicker({
    autoclose: true,
    todayBtn: true,
    pickerPosition: "bottom-left",
    format: 'mm-dd-yyyy hh:ii',
    useCurrent: false,
    debug:true
  });