spinner = function(msg){
  return '<h4><i class="fa fa-spinner fa-spin fa-2x"></i>&nbsp;' + msg + '</h4>'
}

waiting = function(id,msg){
  $(id).html(spinner(msg))
}