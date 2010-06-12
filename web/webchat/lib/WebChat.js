google.load("jquery", "1.4");
google.load("jqueryui", "1.8");

var treegger = new Treegger( "wss://xmpp.treegger.com/tg-1.0/b64")
treegger.onAuthenticationSuccess = function()
{
	$("#login-dialog").dialog('close');
}
treegger.onAuthenticationFailure = function()
{
	alert( "Failure" );
}


google.setOnLoadCallback(function() 
{
	$("#dialog").hide();
	
	$("#login-dialog").dialog({
		height: 300,
		width: 350,
		modal: true,
		buttons: {	
			'Login' : function() 
			{
				var name = $("#name").val(), socialnetwork = $("#socialnetwork").val(), password = $("#password").val();
				var resource = "WebChat";
				treegger.authenticate( name, socialnetwork, password, resource );
			}
		}
	});
	
	/*
	$("#dialog").dialog(
	{
		width: 140,
		height: 400,
		closeOnEscape: false
	}
	) ;
	
	
	
	$("#b1").dblclick( function() { alert("Blabla" ) })
	*/
});

