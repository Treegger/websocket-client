function Treegger( url )
{
	var pingSequence = 0;
	var connected = false;
	var sessionId;
	
	var that = this;
	
	setInterval( this.ping, 30000 );
	
	if ("WebSocket" in window)
	{
		var conn = new WebSocket( url )
		
		conn.onopen = function(evt) 
		{
			that.connected = true;
		};
		
		conn.onmessage = function(event) 
		{ 
			var wsMsg = new com.treegger.protobuf.WebSocketMessage;
			wsMsg.ParseFromStream( new PROTO.Base64Stream( event.data ) );
			that.receiveWebSocketMessage( wsMsg );
		};
		
		
		conn.onerror = function(event) 
		{
		};
			
		conn.onclose = function(evt) 
		{
			that.connected = false;
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
	
	
	this.receiveWebSocketMessage = function( wsMessage )
	{
		if(  wsMessage.authenticateResponse != null )
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
		
		else if( wsMessage.roster != null )
		{
			this.onRoster( wsMessage.roster );
		}
		
		else if( wsMessage.presence != null )
		{
			this.onPresence( wsMessage.presence );
		}

		else if( wsMessage.textMessage != null )
		{
			this.onMessage( wsMessage.textMessage );
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

	
	this.ping = function()
	{
		var pingMsg = new com.treegger.protobuf.Ping;
		pingMsg.id = this.pingSequence.toString();
		this.pingSequence++;
		var wsMsg = new com.treegger.protobuf.WebSocketMessage;
		wsMsg.ping = pingMsg;
		this.sendWebSocketMessage( wsMsg );
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