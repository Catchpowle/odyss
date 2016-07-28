(function(){
  $(document).on('page:load ready', function(){
    if($("#sign_in_modal").length > 0) {
      $("#sign_in_modal").modal('show');
    }
  });
})();
