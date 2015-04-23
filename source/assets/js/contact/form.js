

xdomain.on('warn', function(){
	$('#form-container').html("<div class='alert alert-warning'>Error, could not reach form server. Please use email.</div>")
})



waiting = function(msg){
  return '<i class="fa fa-spinner fa-spin fa-3x col-sm-offset-3"></i><h3 class="col-sm-offset-3">' + msg + '</h3>'
}

$('#frm-contact').validator().on('submit', function(e){
  if (e.isDefaultPrevented()) {
    alert("Please fill out all required fields - highlighted in red")
  } else {
  	e.preventDefault()
	var data = $(this).serialize()
	$('#form-container-outer').html(waiting('Submitting Form'))
	$.ajax({
	  method: "POST",
	  url: $MBLZ_HOST + '/forms',
	  data: data
	})
	.fail(function(){
	  $('#form-container-outer').html('<h2>Something went wrong</h2>The host site has been notified.')
	})
	.done(function(msg){
	  L('done')
	  $('#form-container-outer').hide().html($('#tplThankYou').html()).slideDown('slow')
	})
  }	
})


// $('#form-container').html(waiting('Loading Form'))


window.onerror = function(message, url, lineNumber) {  
  //save error and send to server for example.
	$.ajax({
	  method: "PUT",
	  url: $MBLZ_HOST + '/forms/0',
	  data: {message: message, url: url, lineNumber: lineNumber, browser: navigator.userAgent}
	})  
  return true;
};  