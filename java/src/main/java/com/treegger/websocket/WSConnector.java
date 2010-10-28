package com.treegger.websocket;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.Socket;
import java.net.SocketTimeoutException;
import java.net.UnknownHostException;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;

import javax.net.SocketFactory;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.X509TrustManager;

public class WSConnector 
{

	private WSReader wsReader;
	public void connect( String scheme, String host, int port, String path, boolean trustAnyCertificate, WSEventHandler wsEventHandler ) throws IOException
	{
        wsReader = new WSReader( scheme, host, port, path, trustAnyCertificate, wsEventHandler );
	    wsReader.start();
        
	}
	
    public boolean isClosed()
    {
        if( wsReader.socket != null ) return wsReader.socket.isClosed();
        return true;
    }
    public boolean canSendMessage()
    {
        return !isClosed() && wsReader.socket != null && !wsReader.socket.isOutputShutdown();
    }
	
	
	public void send( String message ) throws IOException
	{
	    if( canSendMessage() )
	    {
            OutputStream os = wsReader.socket.getOutputStream();
            os.write( 0x00 );
            os.write( message.getBytes() );
            os.write( 0xFF );
            os.flush();
	    }
	}

	
	public void send( byte[] message ) throws IOException
	{
	    if( canSendMessage() )
	    {
    		OutputStream os = wsReader.socket.getOutputStream();
    		os.write( 0x80 );
    		int dataLen = message.length;
    		os.write((byte) (dataLen >>> 28 & 0x7F | 0x80));
    		os.write((byte) (dataLen >>> 14 & 0x7F | 0x80));
    		os.write((byte) (dataLen >>> 7 & 0x7F | 0x80));
    		os.write((byte) (dataLen & 0x7F));
    		os.write( message );
    		os.flush();
	    }
	}
	
	public void close() throws IOException
	{
	    wsReader.disconnect();
	}
	
	

	static public interface WSEventHandler
	{
	        public void onOpen();


	        public void onMessage(String message);
	        public void onMessage(byte[] message);


	        public void onError( Exception e );

	        public void onClose();
	        public void onStop();
	}
	
	static public class WSReader extends Thread	
	{
		
		private InputStream input = null;
        private WSEventHandler eventHandler = null;
    	private ByteArrayOutputStream boas = new ByteArrayOutputStream();

    	private Socket socket;
    	
    	private String scheme;
    	private String host;
    	private int port;
    	private String path;
    	
    	private boolean trustAnyCertificate = true;
    	
    	private boolean running = false;
    	
        public WSReader( String scheme, String host, int port, String path, boolean trustAnyCertificate, WSEventHandler eventHandler )
        {
            setName( "WSConnector" );
            this.scheme = scheme;
            this.host = host;
            this.port = port;
            this.path = path;
            this.trustAnyCertificate = trustAnyCertificate;
            this.eventHandler = eventHandler;
            
            running = true;
        }

        
        


        public void disconnect() throws IOException
        {
            running = false;
            synchronized ( this )
            {
                eventHandler = null;
            }
            if( socket != null ) socket.close();
            if( Thread.currentThread() != this )
            {
                interrupt();
            }
        }
        
        private void connect() throws UnknownHostException, IOException, KeyManagementException, NoSuchAlgorithmException
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
                SocketFactory factory;
                if( trustAnyCertificate )
                {
                    SSLContext context = SSLContext.getInstance( "TLS" );
                    context.init( null, new X509TrustManager[] { new X509TrustManager()
                    {
                        public void checkClientTrusted( X509Certificate[] chain, String authType )
                            throws CertificateException
                        {
                        }

                        public void checkServerTrusted( X509Certificate[] chain, String authType )
                            throws CertificateException
                        {
                        }

                        public X509Certificate[] getAcceptedIssuers()
                        {
                            return new X509Certificate[0];
                        }
                    } }, null );
                    
                    factory = (SSLSocketFactory) context.getSocketFactory ();
                }
                else
                    factory = SSLSocketFactory.getDefault();
                
                socket = factory.createSocket( host, port );
            }
            
            
            socket.setTcpNoDelay( true );

            // workaround for android issu => close on socket doesnt throw ex. 
            socket.setSoTimeout( 5000 );

            input = socket.getInputStream();
        
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
            
        }
        
        
        public void run()
        {
            try
            {
                connect();

                synchronized ( this )
                {
                    if( eventHandler != null ) eventHandler.onOpen();
                }    

                while (running)
                {
                    try
                    {
                        int b = input.read();
                        if( running )
                        {
                        	if( b == -1 )
                        	{
                                synchronized ( this )
                                {
                                    if( eventHandler != null ) eventHandler.onClose();
                                }
                        		break;
                        	}
                        	if (b == 0x00) 
                        	{
                                synchronized ( this )
                                {
                                    if( eventHandler != null ) eventHandler.onMessage(  decodeTextFrame() );
                                }
                        	}
                        	else if( b == 0x80 )
                        	{
                                synchronized ( this )
                                {
                                    if( eventHandler != null ) eventHandler.onMessage(  decodeBinaryFrame() );
                                }
                        	}
                        	else
                        	{
                        		throw new IOException( "Unexpected byte: " + Integer.toHexString(b) );
                        	}
                        }
                    }
                    // workaround for android issu => close on socket doesnt throw ex. 
                    catch( SocketTimeoutException e )
                    {
                    }
                }
            }
            catch ( Exception e )
            {
                synchronized ( this )
                {
                    if( eventHandler != null ) eventHandler.onError( e );
                }
            }
            synchronized ( this )
            {            
                if( eventHandler != null ) eventHandler.onStop();
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
        	int b;
        	while( true )
        	{
                b = input.read();
                if( b == 0xFF ) break;
                boas.write( (byte)b );
            } 
        	
        	return boas.toString();
        }

        
        
	}
}
