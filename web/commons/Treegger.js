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

function Treegger( url )
{
	var pingSequence = 0;
	var connected = false;
	var sessionId;
	
	var that = this;
	
	
	if ("WebSocket" in window)
	{
		
		var conn = new WebSocket( url )
		
		setInterval( function()
			{
				var pingMsg = new com.treegger.protobuf.Ping;
				pingMsg.id = pingSequence.toString();
				that.pingSequence++;
				var wsMsg = new com.treegger.protobuf.WebSocketMessage;
				wsMsg.ping = pingMsg;
				that.sendWebSocketMessage( wsMsg );
			}, 30*1000 );
		
		conn.onopen = function(evt) 
		{
			that.connected = true;
			that.onConnect( event );

		};
		
		conn.onmessage = function(event) 
		{ 
			var wsMsg = new com.treegger.protobuf.WebSocketMessage;
			wsMsg.ParseFromStream( new PROTO.Base64Stream( event.data ) );
			that.receiveWebSocketMessage( wsMsg );
		};
		
		
		conn.onerror = function(event) 
		{
			that.onError( event );
		};
			
		conn.onclose = function(evt) 
		{
			that.connected = false;
			that.onDisconnect( event );
		};


	}
	else
	{
	    alert("WebSocket NOT supported\r\n\r\nBrowser: " + navigator.appName + " " + navigator.appVersion );
	}


	this.onAuthenticationFailure = function() {};
	this.onAuthenticationSuccess = function() {};
	this.onRoster = function( roster ) {};
	this.onPresence = function( presence ) {};
	this.onTextMessage = function( textMessage ) {};
	this.onPing = function( textMessage ) {};
	
	this.onConnect = function( e ) {};
	this.onDisconnect = function( e ) {};
	this.onError = function( e ) {};
	
	
	this.isDefined= function( wsMessage, propname )
	{
		
		var descriptor = wsMessage.properties_[propname];
			
		if (!descriptor.type().IsInitialized ||
                descriptor.type().IsInitialized( wsMessage.values_[propname] ) )
        {
			return true;
        }
		return false;
	}

	this.receiveWebSocketMessage = function( wsMessage )
	{
		if( this.isDefined( wsMessage, "authenticateResponse") )
		{
			this.sessionId = wsMessage.authenticateResponse.sessionId;
			
			if( this.sessionId == null )
			{
				this.onAuthenticationFailure();
			}
			else
			{
				this.onAuthenticationSuccess();
			}
		}
		
		else if( this.isDefined( wsMessage, "roster") ) 
		{
			this.onRoster( wsMessage.roster );
		}
		
		else if( this.isDefined( wsMessage, "presence") ) 
		{
			this.onPresence( wsMessage.presence );
		}

		else if( this.isDefined( wsMessage, "textMessage") ) 
		{
			this.onTextMessage( wsMessage.textMessage );
		}
		else if( this.isDefined( wsMessage, "ping") ) 
		{
			this.onPing( wsMessage.ping );
		}

	}
	

	
	
	
	this.sendWebSocketMessage = function( wsMessage  )
	{
		if( this.connected )
		{
			var serialized = new PROTO.Base64Stream;
			wsMessage.SerializeToStream(serialized);
			conn.send(serialized.getString());
		}
	}

	

	
	this.authenticate = function( username, socialnetwork, password, resource )
	{
		var authReqMsg = new com.treegger.protobuf.AuthenticateRequest;
		authReqMsg.username = username+"@"+socialnetwork;
		authReqMsg.password = password;
		authReqMsg.resource = resource;

		var wsMsg = new com.treegger.protobuf.WebSocketMessage;
		wsMsg.authenticateRequest = authReqMsg;
		
		this.sendWebSocketMessage( wsMsg );
	}

	this.sendPresence = function( type, show,	status )
	{
		var presence = new com.treegger.protobuf.Presence;
		presence.type = type;
		presence.show = show;
		presence.status = status;
		
		var wsMsg = new com.treegger.protobuf.WebSocketMessage;
		wsMsg.presence = presence;
		
		this.sendWebSocketMessage( wsMsg );	
	}


	this.sendMessage = function ( to, text )
	{
		var textMsg = new com.treegger.protobuf.TextMessage;
		textMsg.toUser = to;
		textMsg.body = text;

		var wsMsg = new com.treegger.protobuf.WebSocketMessage;
		wsMsg.textMessage = textMsg;
		
		this.sendWebSocketMessage( wsMsg );
	}

	
}