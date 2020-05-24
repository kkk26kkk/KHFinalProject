package com.newface.pro.common;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

public class LoggingListener implements HttpSessionListener {

  @Override
  public void sessionCreated(HttpSessionEvent se) {
    System.out.println(se.getSession().getAttribute("id") + "접속");
  }

  @Override
  public void sessionDestroyed(HttpSessionEvent se) {
    System.out.println(se.getSession().getAttribute("id") + "로그아웃");
  }

}
