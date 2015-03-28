<% unless development? { %>
window.onerror = function(message, url, lineNumber) {  
  //save error and send to server for example.
	$.ajax({
	  method: "PUT",
	  url: 'http://<%=mblz_host%>/forms/0',
	  data: {message: message, url: url, lineNumber: lineNumber, browser: navigator.userAgent}
	})  
  return true;
};  

<% } %>