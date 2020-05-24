package com.newface.pro.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.newface.pro.dao.AllimService;
import com.newface.pro.model.AllimBean;

@Controller
public class AllimAction {
  @Autowired
  private AllimService allimService;

  // 알림 전체 목록 조회
  @RequestMapping(value = "allim_list.nf")
  public Object allimList(HttpServletRequest request) {
    // String id = (String) request.getSession().getAttribute("id");
    // int a_page = 1;
    //
    // Map<String, Object> m = new HashMap<>();
    // m.put("id", id);
    // m.put("a_page", a_page);
    //
    // List<AllimBean> allim_list = allimService.getAllim_list(m);

    ModelAndView mv = new ModelAndView("allim/allim_list");
    // mv.addObject("allim_list", allim_list);

    return mv;
  }

  // 알림 리스트 추가
  @RequestMapping(value = "allim_list_plus.nf", method = RequestMethod.POST)
  @ResponseBody
  public Object allimListPlus(HttpServletRequest request) {
    String id = (String) request.getSession().getAttribute("id");
    int a_page = Integer.parseInt(request.getParameter("a_page"));

    Map<String, Object> m = new HashMap<>();
    m.put("id", id);
    m.put("a_page", a_page);

    List<AllimBean> allim_list = allimService.getAllim_list_plus(m);

    return allim_list;
  }

  // 알림 드롭 다운 시 목록 조회
  @RequestMapping(value = "allim_dropdown_list.nf")
  @ResponseBody
  public Object allimDropdownList(HttpServletRequest request, @RequestParam("id") String id) {

    int a_page = Integer.parseInt(request.getParameter("a_page"));

    Map<String, Object> m = new HashMap<>();
    m.put("id", id);
    m.put("a_page", a_page);

    List<AllimBean> allim_list = allimService.getAllim_dropdown_list(m);

    return allim_list;
  }

  // 새 알림 개수 체크
  @RequestMapping(value = "allim_count_check.nf")
  @ResponseBody
  public Object allim_count_check(@RequestParam("id") String id) {
    int allim_count = allimService.getAllim_count_check(id);

    return allim_count;
  }
}
