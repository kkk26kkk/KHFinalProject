package com.newface.pro.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class Interceptor extends HandlerInterceptorAdapter {

  @Override
  public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
      throws Exception {

    try {
      System.out.println(handler.toString());
      System.out.println("preHandle() : " + request.getRequestURI() + "요청 중");

      // 로그인 상태일 경우 로그인 페이지로 이동하지 못함
      if (request.getSession().getAttribute("id") != null) {
        response.sendRedirect("main.nf");
        return false;
      }
    } catch (Exception e) {
      e.printStackTrace();
    }

    return super.preHandle(request, response, handler);
  }
}
