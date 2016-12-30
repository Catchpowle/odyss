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

    $('.share-button').click(function() {
      window.open(this.href, '', 'left=300,top=200,menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=250,width=600');
      return false;
    });
  });

})();
