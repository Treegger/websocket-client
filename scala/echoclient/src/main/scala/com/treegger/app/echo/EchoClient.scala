package com.treegger.app.echo


import com.treegger.websocket.WSConnector
import com.treegger.websocket.WSConnector._

import com.treegger.protobuf.WebSocketProto._

import java.util.Properties
import java.io.FileInputStream

class EchoClient 
{

    def launch()
    {
        val wsConnector = new WSConnector
        
        val properties = new Properties
        properties.load( new FileInputStream("echoclient.properties" ) )
        
        val handler = new EchoHandler( wsConnector, properties.getProperty("name"), properties.getProperty("socialnetwork"), properties.getProperty("password") )

        while( true )
        {
            try
            {
                wsConnector.connect(  "wss", "xmpp.treegger.com", 443, "/tg-1.0" , handler )
                
                while( !handler.open )
                {
                    Thread.sleep( 1000 )
                }
                while( handler.open )
                {
                    Thread.sleep( 30*1000 )
                    handler.ping()
                }
            }
            catch
            {
                case e:Exception =>
                    println( "Catch exception: " + e.getMessage + "\nReconnecting..." )
                    
            }
        }

    }

    
    class EchoHandler( wsConnector:WSConnector, name:String, socialnetwork:String, password:String ) extends WSEventHandler
    {
        val username = name.trim.toLowerCase+"@"+ socialnetwork.trim.toLowerCase
        var open = false
        var pingId:Int = 0 
        
        def onOpen() 
        {
            open = true
            println("Connected")
            authenticate()
        }

        def onMessage( message:String )
        {
        }
        
        def onMessage(message:Array[Byte])
        {
            val data = WebSocketMessage.newBuilder().mergeFrom( message ).build()
            if( data.hasAuthenticateResponse )
            {
                val authenticateResponse = data.getAuthenticateResponse();
                if( authenticateResponse.hasSessionId && authenticateResponse.getSessionId.length > 0 )
                {
                    println("Authenticated")
                    sendPresence( "", "", "" )
                }
                else
                {
                    throw new Exception( "Authentication failed" )
                }
            }
            
            else if( data.hasTextMessage )
            {
                val textMessage = data.getTextMessage
                println("Echo to: " + textMessage.getFromUser )
                sendMessage( textMessage.getFromUser, textMessage.getBody )
            }
        }


        def onError(e:Exception)
        {
        }

        def onClose()
        {
            open = false
        }

            

        private def authenticate()
        {
            val message = WebSocketMessage.newBuilder
            val authenticateRequest = AuthenticateRequest.newBuilder()
            authenticateRequest.setUsername( username )
            authenticateRequest.setPassword( password.trim() )
            authenticateRequest.setResource( "EchoClient" )
            message.setAuthenticateRequest( authenticateRequest )
            sendWebSocketMessage( message )
        }
        
        def ping()
        {
            val message = WebSocketMessage.newBuilder
            val ping = Ping.newBuilder()
            ping.setId( pingId.toString )
            pingId += 1
            message.setPing( ping )
            sendWebSocketMessage( message )     
        }

        def sendPresence( presenceType:String, show:String, status:String )
        {
            val message = WebSocketMessage.newBuilder
            val presence = Presence.newBuilder()
            presence.setType( presenceType );
            presence.setShow( show )
            presence.setStatus( status )
            presence.setFrom( username )
            message.setPresence( presence )
            sendWebSocketMessage( message )     
        }

        def sendMessage( to:String, text:String )
        {
            val message = WebSocketMessage.newBuilder
            val textMessage = TextMessage.newBuilder()
            textMessage.setBody( text )
            textMessage.setToUser( to )
            textMessage.setFromUser( username )
            message.setTextMessage( textMessage )
            sendWebSocketMessage( message )   
        }

        private  def sendWebSocketMessage(  message:WebSocketMessage.Builder )
        {
            synchronized
            {
                wsConnector.send( message.build.toByteArray )
            }
        }
    
    
    }

}