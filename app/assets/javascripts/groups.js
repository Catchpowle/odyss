(function(){
  $(document).on('page:load ready', function(){
    if($("#sign_in_modal").length > 0) {
      $("#sign_in_modal").modal('show');
    }

    $('.datepicker').datepicker({
            format: 'M d, yyyy'
    });

    $('.copy-invite').click(function() {
      new Clipboard('.copy-invite');
    });
  });

})();
