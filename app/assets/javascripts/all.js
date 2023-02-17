
function checkpassword() { 
    var remember_type = $("#remember-me-eye").attr('type');
    if( remember_type == "text"){
      $("#remember-me-eye").attr('type','password');
}
      else
      { 
      $("#remember-me-eye").attr('type','text');
      }
  }

