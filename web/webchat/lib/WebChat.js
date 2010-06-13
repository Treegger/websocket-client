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
		var element = $("<li>"+value.name+"</li>")
		element.dblclick( function( event )
		{
			createChatWith( value );
		}
		);
		
		rosterList.append( element)
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


function getUserFromJID( jid )
{
	var i = jid.indexOf( "@" )
	if( i > 0 ) return jid.substring( 0, i );
	else return jid;
}

var chatDialogVisible = false;
function createChatWith( rosterItem )
{
	if( !chatDialogVisible )
	{
		$("#chat-dialog").dialog(
			{
				width: 520,
				heigh: 400,
				resizable: false,
				closeOnEscape: false
			}
		);
	
		$("#chat-tabs").tabs();
		chatDialogVisible = true;
	}
	
	var userId = getUserFromJID( rosterItem.jid );
	$("#chat-tabs").tabs( "add", "#tab-"+userId, rosterItem.name );
	
	var chatTab = $("#tab-"+userId);
	chatTab.append( "<textarea readonly style='width: 470px; height: 230px;resize:none;'/>" );
	
	var input = $("<input type='text' style='width: 470px;'></input>");
	input.keypress( function( event ){
		if( event.keyCode == 13 )
		{
			addTextToChatTab( chatTab, "You", event.currentTarget.value )
		}
	});
	chatTab.append( input );
}


function addTextToChatTab( chatTab, from, text )
{
	var textarea = chatTab.find( 'textarea');
	textarea.html( textarea.text() + '\n' + from + ": " + text );
	textarea.scrollTop( textarea.innerHeight() );
	event.currentTarget.value = "";

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



