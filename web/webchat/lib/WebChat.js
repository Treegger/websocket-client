/*
Simplified BSD License

Copyright 2010 Treegger. All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are
permitted provided that the following conditions are met:

   1. Redistributions of source code must retain the above copyright notice, this list of
      conditions and the following disclaimer.

   2. Redistributions in binary form must reproduce the above copyright notice, this list
      of conditions and the following disclaimer in the documentation and/or other materials
      provided with the distribution.

THIS SOFTWARE IS PROVIDED BY TREEGGER ``AS IS'' AND ANY EXPRESS OR IMPLIED
WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> OR
CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

The views and conclusions contained in the software and documentation are those of the
authors and should not be interpreted as representing official policies, either expressed
or implied, of Treegger.
 */


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
	treegger.sendPresence( "", "", "" );
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

	$.each( roster.item, function(index, rosterItem) { 
		var uid = getUIDFromJID( rosterItem.jid );
		var element = $("<li id='roster-item-"+uid+"'>"+rosterItem.name+"</li>")
		element.dblclick( function( event )
		{
			createChatWith( rosterItem );
			openChatDialog();
		}
		);
		
		rosterList.append( element)
	});
}

treegger.onPresence = function( presence ) 
{
	var rosterList = $("#roster-list")

	var uid = getUIDFromJID( presence.from );
	var li = $("#roster-item-"+ uid );
	if( presence.type != null && presence.type.toLowerCase() == "unavailable")
	{
		rosterList.append( li.detach() );
		li.removeClass().addClass( "presenceUnvailable" )
	}
	else
	{
		var show;
		if( presence.show != null )
		{
			show = presence.show.toLowerCase();
		}
		if( show != null && ( show == "away" || show == "dnd" || show == "xa") ) li.removeClass().addClass( "presenceAway" )
		else
		{
			rosterList.prepend( li.detach() );
			li.removeClass().addClass( "presenceAvailable" )
		}
	}
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
			if( chatTab.length == 0 )
			{
				chatTab = createChatWith( rosterItem );
			}
			openChatDialog();
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


function openChatDialog()
{
	var chatDialog = $("#chat-dialog");
	if( ! chatDialog.dialog( "isOpen" ) ) chatDialog.dialog( "open" );
}

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
		name = name.replace( "@", "#" );
		var socialnetwork = form.find('select[name=socialnetwork]').val();
		var password = form.find('input[name=password]').val();
		var resource = "WebChat";

		$("#login-dialog").dialog( "disable" );
		treegger.authenticate( name, socialnetwork, password, resource );
		return false;
	}
});



