package net.easyUI.web.action.demo;
import java.io.IOException;
import java.util.Iterator;
import java.util.Set;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/chat")
public class WebSocketTest  {
 
@OnMessage
public void onMessage(String message, Session session)
    throws IOException, InterruptedException {
    // Print the client message for testing purposes
    
    System.out.println("Received: " + message);
    
    /*List<MyWebSocket> socketList = InitServlet.getSocketList();  
        for (MyWebSocket socket : socketList) {  
            try {  
                socket.getConn().sendMessage(data);  
            } catch (IOException e) {  
                e.printStackTrace();  
            }  
        }  */
  //  session.getAsyncRemote().sendText(message);
    Set<Session> set=session.getOpenSessions();
    Iterator<Session> it=set.iterator();
    while(it.hasNext()){
        Session everySession=it.next();
        if(everySession.isOpen()){
            everySession.getBasicRemote().sendText(message);
        }
    }
    //session.getBasicRemote().sendText(message);
    // Send the first message to the client
   // session.getBasicRemote().sendText("This is the first server message");
    // Send 3 messages to the client every 5 seconds
    /* int sentMessages = 0;
      while(sentMessages < 3){
      Thread.sleep(5000);
      session.getBasicRemote().
        sendText("This is an intermediate server message. Count: "
          + sentMessages);
      sentMessages++;
    }*/
    // Send a final message to the client
    //session.getBasicRemote().sendText("This is the last server message");
  }
  @OnOpen
  public void onOpen() {
    System.out.println("Client connected");
  }
  @OnClose
  public void onClose() {
    System.out.println("Connection closed");
  }
}
