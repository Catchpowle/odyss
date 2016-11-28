(function(){
  $(document).on('ready', function(){
    if(Cookies.get('unauthorized')) {
      $("#sign_in_modal").modal('show');
      Cookies.remove('unauthorized');
    }

    $('.datepicker').datepicker({
      format: 'M d, yyyy'
    });

    $('.copy-invite').click(function() {
      new Clipboard('.copy-invite');
    });
  });

})();
