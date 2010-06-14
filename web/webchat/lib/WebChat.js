google.load("jquery", "1.4");
google.load("jqueryui", "1.8");


function outputDebug( text )
{
	//var textarea = $("#debug-area");	
	//textarea.html( textarea.text() + '\n' + text );	
}

var treegger = new Treegger( "wss://xmpp.treegger.com/tg-1.0/b64")

treegger.onConnect = function()
{
	$("#connected-box").show();
	$("#disconnected-box").hide();
}
treegger.onDisconnect = function()
{
	$("#connected-box").hide();
	$("#disconnected-box").show();
}

treegger.onAuthenticationSuccess = function()
{
	$("#login-dialog").dialog('close');
}
treegger.onPing = function()
{
	outputDebug( "Pong" )
}

treegger.onAuthenticationFailure = function()
{
	$("#login-dialog").dialog( "enable" );
	alert( "Authentication Failure" );
}


var roster;
treegger.onRoster = function( remoteRoster )
{
	roster = remoteRoster;
	var rosterDialog = $("#roster-dialog");
	rosterDialog.dialog(
			{
				width: 140,
				height: 400,
				closeOnEscape: false
			}
		);
	var rosterList = $("#roster-list")
	rosterDialog.show();

	$.each( roster.item, function(index, value) { 
		var element = $("<li>"+value.name+"</li>")
		element.dblclick( function( event )
		{
			createChatWith( value );
		}
		);
		
		rosterList.append( element)
	});
}


treegger.onTextMessage = function( textMessage ) 
{
	if( textMessage.fromUser != null && textMessage.body != null )
	{
		var rosterItem = getRosterItemFromJID( textMessage.fromUser );
		if( rosterItem != null )
		{
			var userId = "uid-"+getUIDFromJID( rosterItem.jid );
			var chatTab = $("#tab-"+userId);
			if( chatTab == null )
			{
				chatTab = createChatWith( rosterItem );
			}
			addTextToChatTab( chatTab, rosterItem.name, textMessage.body )
		}
	}
}


var idMap = {};
var uidMapIndex = 1;

function getRosterItemFromJID( jid )
{
	var userAndHost = getUserAndHost(jid);
	for( i in roster.item ){
		var value = roster.item[i];
		if( userAndHost == value.jid )
		{
			return value;
		}
	}
	return null;
}

function getUserAndHost( jid )
{
	var userAndHost = jid;
	var i = jid.indexOf( '/' )
	if( i > 0 ) userAndHost = jid.substring( 0, i );
	return userAndHost;
}

function getUIDFromJID( jid )
{
	
	var uid = idMap[getUserAndHost(jid)];
	if( uid == null )
	{
		uid = uidMapIndex;
		idMap[jid] = uid;
		uidMapIndex ++;
	}
	return uid;
}

var chatDialogVisible = false;
var chatTabs = {};

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
	
	var uid = getUIDFromJID( rosterItem.jid );
	
	var chatTab = chatTabs[uid];
	if( chatTab == null )
	{
		$("#chat-tabs").tabs( "add", "#tab-uid-"+uid, rosterItem.name );
		
		chatTab = $("#tab-uid-"+uid);
		chatTabs[uid] = chatTab;
		         
		chatTab.append( "<textarea readonly style='width: 470px; height: 230px;resize:none;'/>" );
		
		var input = $("<input type='text' style='width: 470px;'></input>");
		input.keypress( function( event ){
			if( event.keyCode == 13 )
			{
				treegger.sendMessage( rosterItem.jid, event.currentTarget.value )
				addTextToChatTab( chatTab, "You", event.currentTarget.value );
			}
		});
		chatTab.append( input );
	}
	
	return chatTab;

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
		var socialnetwork = form.find('select[name=socialnetwork]').val();
		var password = form.find('input[name=password]').val();
		var resource = "WebChat";

		$("#login-dialog").dialog( "disable" );
		treegger.authenticate( name, socialnetwork, password, resource );
		return false;
	}
});



