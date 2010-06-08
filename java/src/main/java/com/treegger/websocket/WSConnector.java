package com.treegger.websocket;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.Socket;

import javax.net.SocketFactory;
import javax.net.ssl.SSLSocketFactory;

public class WSConnector 
{

	private Socket socket;
	
	public void connect( String scheme, String host, int port, String path, WSEventHandler wsEventHandler ) throws IOException
	{
        
        
        
        if( scheme.equals("ws") ) 
        {
            if (port == -1) 
            {
                    port = 80;
            }
            socket = new Socket(host, port);
        }
        else if( scheme.equals("wss") )
        {
            if (port == -1) {
            	port = 443;
            }
        	SocketFactory factory = SSLSocketFactory.getDefault();
        	socket = factory.createSocket( host, port );
        }
        

        InputStream input = socket.getInputStream();
    
        String handshake = "GET " + path + " HTTP/1.1\r\n" +
        					"Upgrade: WebSocket\r\n" +
        					"Connection: Upgrade\r\n" +
        					"Host: " + host + "\r\n" +
        					"Origin: http://" + host     
        					+ "\r\n"
        					+ "\r\n";
        
        OutputStream os = socket.getOutputStream();
        os.write( handshake.getBytes() );
        os.flush();
        
        BufferedReader reader = new BufferedReader( new InputStreamReader(input) );
        String line = reader.readLine();
        if ( !line.equals("HTTP/1.1 101 Web Socket Protocol Handshake") ) 
        {
        	throw new IOException("unable to connect to server");
        }
        
        wsEventHandler.onOpen();
    
        new WSReader( input, wsEventHandler ).start();
        
	}
	
	
	public void send( String message ) throws IOException
	{
        OutputStream os = socket.getOutputStream();
        os.write( 0x00 );
        os.write( message.getBytes() );
        os.write( 0xFF );
        os.flush();
	}

	
	public void send( byte[] message ) throws IOException
	{
		OutputStream os = socket.getOutputStream();
		os.write( 0x80 );
		int dataLen = message.length;
		os.write((byte) (dataLen >>> 28 & 0x7F | 0x80));
		os.write((byte) (dataLen >>> 14 & 0x7F | 0x80));
		os.write((byte) (dataLen >>> 7 & 0x7F | 0x80));
		os.write((byte) (dataLen & 0x7F));
		os.write( message );
		os.flush();
	}
	
	public void close() throws IOException
	{
		socket.close();
	}
	
	

	static public interface WSEventHandler
	{
	        public void onOpen();


	        public void onMessage(String message);
	        public void onMessage(byte[] message);


	        public void onError( Exception e );


	        public void onClose();
	}
	
	static public class WSReader extends Thread	
	{
		
		private InputStream input = null;
        private WSEventHandler eventHandler = null;
    	private ByteArrayOutputStream boas = new ByteArrayOutputStream();

        public WSReader(InputStream input, WSEventHandler eventHandler )
        {
                this.input = input;
                this.eventHandler = eventHandler;
                
        }

        public void run()
        {

            while (true)
            {
                try 
                {
                	int b = input.read();
                	if( b == -1 )
                	{
                		eventHandler.onClose();
                		break;
                	}
                	if (b == 0x00) 
                	{
                		eventHandler.onMessage(  decodeTextFrame() );
                	}
                	else if( b == 0x80 )
                	{
                		eventHandler.onMessage(  decodeBinaryFrame() );
                	}
                	else
                	{
                		throw new IOException( "Unexpected byte: " + Integer.toHexString(b) );
                	}
            	}
                catch (IOException e) 
                {
                    eventHandler.onClose();
                    try 
                    {
						input.close();
					} catch (IOException e1) 
					{
					}
					eventHandler.onError( e );
                    break;
                }
            }
        }
        
        private byte[] decodeBinaryFrame() throws IOException {
            long frameSize = 0;
            int lengthFieldSize = 0;
            byte b;
            do {
                b = (byte)input.read();
                frameSize <<= 7;
                frameSize |= b & 0x7f;
                lengthFieldSize ++;
                if (lengthFieldSize > 8) {
                    throw new IOException( "Unexpected lengthFieldSize");
                }
            }
            while( (b & 0x80) == 0x80 );

            byte[] buffer = new byte[(int)frameSize];
            input.read(buffer);
            return buffer;
        }

        private String decodeTextFrame() throws IOException 
        {
        	boas.reset();
        	byte b;
        	do 
        	{
                b = (byte)input.read();
                boas.write( b );
            } 
        	while( (b & 0xFF) == 0xFF );
        	
        	return boas.toString();
        }

        
        
	}
}
