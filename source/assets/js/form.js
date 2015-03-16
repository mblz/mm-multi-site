// //do some vanilla XHR
// var xhr = new XMLHttpRequest();
// xhr.open('GET', 'http://localhost:3000/forms');
// xhr.onreadystatechange = function(e) {
//   if(xhr.readyState === 4)
//     alert(xhr.responseText);
// };
// xhr.send();

//or if we are using jQuery...

$HOST= window.location.hostname.indexOf('localhost') != 0 ? $SITE + ".mblz.com" : 'localhost:3000'
$RES = 'http://' + $HOST + '/forms'
$.get($RES).done(function(data) {
	var f = $('#form-container')
	var t = $.templates("#tplText");
  $(data).each(function(){
  	console.log(this)
  	f.append(t.render(this))
  })
});


$('#frm-contact').validator().on('submit', function(e){
  if (e.isDefaultPrevented()) {
    alert("Please fill out all required fields")
  } else {
  	e.preventDefault()
	  var data = $(this).serialize()
		$.ajax({
		  method: "POST",
		  url: $RES,
		  data: data
		}).done(function(msg){
		  $('#form-container-outer').html('<H1>Thank you</H1>')
		})
  }	
})