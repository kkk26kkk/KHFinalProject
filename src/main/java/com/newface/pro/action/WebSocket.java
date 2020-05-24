package com.newface.pro.action;

import java.util.ArrayList;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/websocket")
public class WebSocket {

  private static ArrayList<Session> sessionList = new ArrayList<Session>();
  /*
   * �냼耳� �꽭�뀡�쓣 �떞�뒗 ArrayList
   */
  // private static ArrayList<WsBean> WsBeanList = new ArrayList<WsBean>();
  /* �븳 �꽭�뀡�뿉 ���븳 �젙蹂대�� �떞�뒗 ArrayList */

  @OnOpen
  public void handleOpen(Session session) {
    if (session != null) {
      String sessionId = session.getId();
      System.out.println("client is connected. sessionId==[" + sessionId + "]");
      sessionList.add(session);
    }
  }

  /*
   * �쎒�냼耳� Message From Client �닔�떊�븯�뒗 寃쎌슦 �샇異�
   */
  @OnMessage
  public String handleMessage(String message, Session session) {
    if (session != null) {

      /* WsBean wsbean = new WsBean(); */

      String sessionId = session.getId();
      System.out
          .println("message arrived. sessionId==[" + sessionId + "]/message == [" + message + "]");
      // 'user_id' �떂�씠 梨꾪똿諛⑹뿉 �엯�옣�븯�뀲�뒿�땲�떎: 'id2'�떂怨쇱쓽 �씪���씪 ���솕�엯�땲�떎.

      // �쎒 �냼耳� �뿰寃� �꽦由쎈릺�뼱 �엳�뒗 紐⑤뱺 �궗�슜�옄�뿉寃� message �쟾�넚
      sendMessageToAll(message);
      // 硫붿떆吏� database�뿉 ���옣
    }
    return null;
  }


  /*
   * �쎒 �냼耳� �궗�슜�옄 �뿰寃� �빐�젣�븯�뒗 寃쎌슦 �샇異�
   */
  @OnClose
  public void handleClose(Session session) {
    if (session != null) {
      String sessionId = session.getId();
      System.out.println("client is disconnected. sessionId==[" + sessionId + "]");

    }
  }

  /*
   * �쎒 �냼耳� error 諛쒖깮�븯�뒗 寃쎌슦 �샇異�
   */

  @OnError
  public void handleError(Throwable t) {
    t.printStackTrace();
  }

  /*
   * �쎒 �냼耳� �뿰寃� �꽦由쎈릺�뼱 �엳�뒗 紐⑤뱺 �궗�슜�옄�뿉寃� message �쟾�넚
   */

  private boolean sendMessageToAll(String message) {
    if (sessionList == null) {
      return false;
    }

    int sessionCount = sessionList.size();
    if (sessionCount < 1) {
      return false;
    }

    Session singleSession = null;

    for (int i = 0; i < sessionCount; i++) {
      singleSession = sessionList.get(i);
      if (singleSession == null) {
        continue;
      }

      if (!singleSession.isOpen()) {
        continue;
      }

      sessionList.get(i).getAsyncRemote().sendText(message);
    }

    return true;
  }
}
