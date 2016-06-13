$(document).ready(function () {
  // Delete confirmation modals
  $('#confirmation-modal-container').on('shown.bs.modal', function() {
    var $submit = $(this).find('.btn-danger'), 
        href = $submit.attr('href');
    $submit.attr('href', href.replace('replacableId', $(this).data('id')));
  });

  $('.confirmation-button').click(function(e) {
    e.preventDefault();
    $('#confirmation-modal-container').data('id', $(this).data('id')).modal('show');
  });
});