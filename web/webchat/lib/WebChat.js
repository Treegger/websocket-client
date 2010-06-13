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

treegger.onRoster = function( roster )
{
	var rosterDialog = $("#roster-dialog");
	var rosterList = $("#roster-list")
	$.each( roster.item, function(index, value) { 
		rosterList.append( "<li>"+value.name+"</li>")
	});
	rosterDialog.dialog(
		{
			width: 140,
			height: 400,
			closeOnEscape: false
		}
	);
	rosterDialog.show();

	
}

google.setOnLoadCallback(function() 
{
	
	$("#login-dialog").dialog({
		height: 300,
		width: 350,
		show: 'blind',
		hide: 'explode',
		modal: true,
		buttons: {	
			'Login' : login 
		}
	});

	$("#login-form").submit( login );


	function login()
	{
		var form = $("#login-form")
		var name = form.find('input[name=name]').val();
		var socialnetwork = form.find('input[name=socialnetwork]').val();
		var password = form.find('input[name=password]').val();
		var resource = "WebChat";
		
		treegger.authenticate( name, socialnetwork, password, resource );
		return false;
	}
});



