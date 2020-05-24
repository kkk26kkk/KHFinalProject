package com.newface.pro.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.newface.pro.dao.MainService;
import com.newface.pro.dao.TimeLineService;
import com.newface.pro.model.BoardBean;
import com.newface.pro.model.MemberBean;

@Controller
public class TimeLineAction {
  @Autowired
  private TimeLineService timelineService;
  @Autowired
  private MainService mainservice;

  // 타임라인 페이지로 이동
  @RequestMapping(value = "timeline.nf", method = {RequestMethod.POST, RequestMethod.GET})
  public ModelAndView test(HttpServletRequest request,
      @RequestParam(value = "a_no", required = false) String a_no, @RequestParam String id)
      throws Exception {

    HttpSession session = request.getSession(); // 세션 객체 생성
    String sessionid = (String) session.getAttribute("id");

    // 세션 친구 정보 구하기
    List<MemberBean> m_list = new ArrayList<MemberBean>();
    m_list = timelineService.getmemberinfo(sessionid);

    // 유저 정보 구하기
    MemberBean memberinfo = (MemberBean) mainservice.userInfo(id);

    // 해당 유저의 친구 불러오기
    List<MemberBean> t_list = timelineService.getmemberinfo(id);

    System.out.println("id1 = " + memberinfo.getId());

    // 1)알림을 타고온 경우 - 해당 알림을 '읽음'으로 체크 후 해당 타임라인 페이지로 이동
    if (a_no != null) {
      // 타고온 알림을 '읽음'으로 바꿈
      timelineService.setReadCheck(Integer.parseInt(a_no));

      ModelAndView mv = new ModelAndView("timeline/timeline");
      mv.addObject("friendlist", m_list);
      mv.addObject("sessionid", sessionid);
      mv.addObject("m", memberinfo);
      mv.addObject("t_fList", t_list);

      return mv;
    }
    // 2)그냥 온 경우 - 그냥 타임라인 페이지로 이동
    else {
      ModelAndView mv = new ModelAndView("timeline/timeline");
      mv.addObject("friendlist", m_list);
      mv.addObject("sessionid", sessionid);
      mv.addObject("m", memberinfo);
      mv.addObject("t_fList", t_list);

      return mv;
    }
  }

  @RequestMapping(value = "/timeListPlus", method = RequestMethod.POST)
  @ResponseBody
  public Object myListPlus(HttpServletRequest request, HttpServletResponse response,
      @RequestParam int page, @RequestParam String id) throws Exception {
    List<BoardBean> list = new ArrayList<BoardBean>();

    HttpSession session = request.getSession(); // 세션 객체 생성
    String sessionid = (String) session.getAttribute("id");

    Map m = new HashMap();
    m.put("page", page);
    m.put("id", id);
    m.put("like_id", sessionid);

    System.out.println("id2 = " + id);
    list = timelineService.timeListPlus(m);

    return list;

  }

  @RequestMapping(value = "board", method = {RequestMethod.POST, RequestMethod.GET})
  @ResponseBody
  public ModelAndView board(HttpServletRequest request, @RequestParam String id,
      @RequestParam int board_no, @RequestParam(value = "a_no", required = false) String a_no)
      throws Exception {

    HttpSession session = request.getSession(); // 세션 객체 생성
    String sessionid = (String) session.getAttribute("id");

    // 세션 친구 정보 구하기
    List<MemberBean> m_list = new ArrayList<MemberBean>();
    m_list = timelineService.getmemberinfo(sessionid);

    // 유저 정보 구하기
    MemberBean memberinfo = (MemberBean) mainservice.userInfo(id);

    /*
     * Map m = new HashMap(); m.put("id", id); m.put("board_no",board_no); m.put("like_id",
     * sessionid);
     * 
     * //게시글 정보 가져오기 BoardBean b_list = new BoardBean(); try { b_list =
     * timelineService.get_oneboard(m); }catch(NullPointerException ne) {
     * 
     * } //날짜 int year = (Integer.parseInt(b_list.getReg_date().substring(0,4))); int month =
     * (Integer.parseInt(b_list.getReg_date().substring(5,7))); int day =
     * (Integer.parseInt(b_list.getReg_date().substring(8,10)));
     * 
     * //파일 String[] filePathArr = b_list.getBoard_file().split("\\|"); String extn[] = null; for
     * (int i = 0 ; i < filePathArr.length ; i++){ extn[i]=
     * filePathArr[i].substring(filePathArr[i].lastIndexOf('.')+1).toLowerCase();
     * System.out.println(i + " 번째 = " + extn); } System.out.println(filePathArr[0]);
     * 
     * 
     * // 1)알림을 타고온 경우 - 해당 알림을 '읽음'으로 체크 후 해당 타임라인 페이지로 이동 if (a_no != null) { // 타고온 알림을 '읽음'으로 바꿈
     * timelineService.setReadCheck(Integer.parseInt(a_no));
     * 
     * ModelAndView mv = new ModelAndView("timeline/board"); mv.addObject("friendlist", m_list);
     * mv.addObject("sessionid", sessionid); mv.addObject("m", memberinfo); mv.addObject("b",
     * b_list);
     * 
     * return mv; }
     * 
     * // 2)그냥 온 경우 - 그냥 타임라인 페이지로 이동 else {
     * 
     * ModelAndView mv = new ModelAndView("timeline/board"); mv.addObject("friendlist", m_list);
     * mv.addObject("sessionid", sessionid); mv.addObject("m", memberinfo); mv.addObject("b",
     * b_list); return mv;
     * 
     * }
     * 
     */

    timelineService.setReadCheck(Integer.parseInt(a_no));

    ModelAndView mv = new ModelAndView("timeline/board");
    mv.addObject("friendlist", m_list);
    mv.addObject("sessionid", sessionid);
    mv.addObject("m", memberinfo);
    mv.addObject("id", id);
    mv.addObject("board_no", board_no);
    return mv;

  }

  // 알림 타고온 게시글 하나 상세 보기
  @RequestMapping(value = "/boardOne", method = RequestMethod.POST)
  @ResponseBody
  public Object boardOne(HttpServletRequest request, HttpServletResponse response,
      @RequestParam int board_no, @RequestParam String id/* , @RequestParam int a_flag */)
      throws Exception {


    HttpSession session = request.getSession(); // 세션 객체 생성
    String sessionid = (String) session.getAttribute("id");

    Map m = new HashMap();
    m.put("board_no", board_no);
    m.put("id", id);
    m.put("like_id", sessionid);

    // 알림 등록
    // AllimBean allim = new AllimBean();
    // allim.setA_flag(a_flag);
    // allim.setId((String) session.getAttribute("id"));
    // allim.setAccept_id(id);
    // allim.setBoard_no(board_no);

    // mainservice.like_allim(allim);

    List<BoardBean> list = new ArrayList<BoardBean>();
    list = timelineService.get_oneboard(m);

    return list;

  }

  // 정보버튼 클릭시 정보 보여주기
  @RequestMapping(value = "/infoshow", method = RequestMethod.POST)
  @ResponseBody
  public Object infoshow(@RequestParam String id, MemberBean mb) throws Exception {

    Map m = new HashMap();
    m.put("id", id);

    mb = timelineService.tm_info(m);

    return mb;

  }

  // 정보 더 보기
  @RequestMapping(value = "/infoshowplus", method = RequestMethod.POST)
  @ResponseBody
  public Object infoshowplus(HttpServletRequest request, @RequestParam String id, MemberBean mb)
      throws Exception {

    HttpSession session = request.getSession(); // 세션 객체 생성
    String sessionid = (String) session.getAttribute("id");


    Map m = new HashMap();
    m.put("id", id);
    m.put("sessionid", sessionid);

    mb = timelineService.infoshowplus(m);

    return mb;

  }
}
