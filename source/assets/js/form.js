$HOST= window.location.hostname.indexOf('localhost') != 0 ? $SITE + ".mblz.com" : 'localhost:3000'
$RES = 'http://' + $HOST + '/forms'

xdomain.on('warn', function(){
	$('#form-container').html("<div class='alert alert-warning'>Error, could not reach form server. Please use email.</div>")
})

$.get($RES).done(function(data) {	
  $('#form-container').html('')	
	$('#btnSubmitContact').show()
  $(data).each(function(){
  	//console.log(this.field_type)
  	$('#form-container').append(RenderTemplate('#tpl' + this.field_type, this))
  })
});

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
		  url: $RES,
		  data: data
		}).done(function(msg){
		  $('#form-container-outer').html('<H2 class=page-header>Thank you, you have successfully submitted the contact form</H2><h3>Someone will contact you shortly</h3>')
		})
  }	
})


$('#form-container').html(waiting('Loading Form'))