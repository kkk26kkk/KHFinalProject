package com.newface.pro.action;

import java.io.File;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.newface.pro.dao.MainService;
import com.newface.pro.model.AllimBean;
import com.newface.pro.model.BoardBean;
import com.newface.pro.model.BoardLikeBean;
import com.newface.pro.model.FriendListBean;
import com.newface.pro.model.MemberBean;
import com.newface.pro.model.ReplyBean;

@Controller
public class MainAction {
  @Autowired
  private MainService mainservice;

  private String saveFolder =
      "C:\\Users\\kkk26\\git\\FinalProject\\FinalProject\\src\\main\\webapp\\resources\\upload\\file";
  // private String saveFolder = "/var/lib/tomcat8/webapps/pro/resources/upload/file";

  // 메인 페이지
  @RequestMapping(value = "/main.nf", method = {RequestMethod.POST, RequestMethod.GET})
  public ModelAndView main(HttpServletRequest request, HttpServletResponse response)
      throws Exception {

    HttpSession session = request.getSession(); // 세션 객체 생성
    String id = (String) session.getAttribute("id");
    ModelAndView mv = new ModelAndView();

    // 친구 정보 구하기
    List<MemberBean> m_list = new ArrayList<MemberBean>();
    m_list = mainservice.getmemberinfo(id);

    // 친구 요청 목록 가져오기
    List<MemberBean> frBean = mainservice.getFriend_request(id);
    // 매칭 요청 목록 가져오기
    List<MemberBean> mrBean = mainservice.getMfriend_request(id);

    /** 매칭 관심사 맞는 목록들 랜덤으로 불러오기 **/
    // List<MemberBean> match_list = null;
    // String[] m_hobby = null;
    // try {
    // String[] m_hobby = memberService.getMember(id).getM_hobby().split(",");
    // if (m_hobby != null) {
    // for (int i = 0; i < m_hobby.length; i++) {
    // m_hobby[i] = "'%" + m_hobby[i] + "%'";
    // }
    // Map<String, Object> search_map = new HashMap<>();
    // search_map.put("id", id);
    // search_map.put("m_hobby", m_hobby);
    // List<MemberBean> match_list = matchingService.matching_search(search_map);
    // mv.addObject("match_list", match_list);
    // }
    // } catch (NullPointerException e) {
    // e.printStackTrace();
    // } finally {
    // mv.setViewName("main/main");
    // mv.addObject("friendlist", m_list);
    // mv.addObject("frBean", frBean);
    // mv.addObject("mrBean", mrBean);
    // }

    mv.setViewName("main/main");
    mv.addObject("friendlist", m_list);
    mv.addObject("frBean", frBean);
    mv.addObject("mrBean", mrBean);

    return mv;
  }

  // 스크롤 내리면 게시물 플러스
  @RequestMapping(value = "/boardListPlus", method = RequestMethod.POST)
  @ResponseBody
  public Object boardListPlus(HttpServletRequest request, HttpServletResponse response,
      @RequestParam int page) throws Exception {
    List<BoardBean> list = new ArrayList<BoardBean>();

    HttpSession session = request.getSession(); // 세션 객체 생성
    String id = (String) session.getAttribute("id");

    Map m = new HashMap();
    m.put("page", page);
    m.put("id", id);

    list = mainservice.BoardListPlus(m);

    return list;
  }

  // 댓글 리스트 보기
  @RequestMapping(value = "/replyshow", method = RequestMethod.POST)
  @ResponseBody
  public Object replyshow(@RequestParam String id, @RequestParam int board_no,
      @RequestParam(value = "r_page", defaultValue = "1", required = false) int r_page)
      throws Exception {
    List<ReplyBean> list = new ArrayList<ReplyBean>();

    Map m = new HashMap();
    m.put("id", id);
    m.put("board_no", board_no);
    m.put("r_page", r_page);
    System.out.println("r_page =" + r_page);
    list = mainservice.ReplyShow(m);

    return list;
  }

  // 댓글 플러스 보기
  @RequestMapping(value = "/replyShowPlus", method = RequestMethod.POST)
  @ResponseBody
  public Object replyShowPlus(@RequestParam String id, @RequestParam int board_no,
      @RequestParam(value = "r_page", defaultValue = "1", required = false) int r_page)
      throws Exception {
    List<ReplyBean> list = new ArrayList<ReplyBean>();
    System.out.println("r_page =" + r_page);
    Map m = new HashMap();
    m.put("id", id);
    m.put("board_no", board_no);
    m.put("r_page", r_page);

    list = mainservice.ReplyShowPlus(m);

    return list;
  }

  // 게시물 등록
  @RequestMapping(value = "/boardInsert", method = RequestMethod.POST)
  @ResponseBody
  public Object boardInsert(HttpServletRequest request, HttpServletResponse response, BoardBean b)
      throws Exception {

    // 세션으로 회원 정보 구하기
    HttpSession session = request.getSession(); // 세션 객체 생성
    String id = (String) session.getAttribute("id");

    MemberBean mb = new MemberBean();
    mb = mainservice.userInfo(id);
    // 회원 board_no 최대값 구하기
    int board_no = mainservice.count_bn(id) + 1;

    MultipartFile[] uploadfile = b.getUploadfile();
    System.out.println("uploadfile.length = " + uploadfile.length);
    String fileNameAll = "";
    String fileDBNameAll = "";
    if (!uploadfile[0].isEmpty()) {
      String fileName = null;
      String fileDBName = null;
      for (int i = 0; i < uploadfile.length - 1; i++) {
        // 원래 파일명 구해오기
        fileName = uploadfile[i].getOriginalFilename();
        // DB에 저장할 파일명 구해오기
        fileDBName = getFileDBName(fileName);
        // 업로드한 파일을 매개변수의 경로에 저장
        uploadfile[i].transferTo(new File(saveFolder + fileDBName));
        fileNameAll += fileName + "|";
        fileDBNameAll += fileDBName + "|";
      }
    }

    // 원래 파일명 저장
    b.setBoard_original(fileNameAll);
    // 바뀐 파일명 저장
    b.setBoard_file(fileDBNameAll);
    b.setId(id);
    b.setName(mb.getName());
    b.setBoard_no(board_no);
    mainservice.insertBoard(b);

    // board_like insert
    b.setLike_id(id);
    mainservice.insertBoard_like(b);

    List<FriendListBean> f_list = new ArrayList<FriendListBean>();
    f_list = mainservice.getFriends(id);

    for (int i = 0; i < f_list.size(); i++) {
      b.setLike_id(f_list.get(i).getId2());
      mainservice.insertBoard_like(b);
    }

    Map m = new HashMap();
    m.put("id", id);
    m.put("board_no", board_no);

    List<BoardBean> list = new ArrayList<BoardBean>();

    list = mainservice.get_board(m);

    return list;
  }

  // 댓글 등록
  @RequestMapping(value = "/replyInsert", method = RequestMethod.POST)
  @ResponseBody
  private Object replyInsert(HttpServletRequest request, HttpServletResponse response,
      @RequestParam String id, @RequestParam int board_no, @RequestParam String content,
      @RequestParam int a_flag, ReplyBean rb) throws Exception {
    // 세션으로 회원 정보 구하기
    HttpSession session = request.getSession(); // 세션 객체 생성
    String sessionid = (String) session.getAttribute("id");
    MemberBean mb = new MemberBean();
    mb = mainservice.userInfo(sessionid);

    Map m = new HashMap();
    m.put("id", id);
    m.put("board_no", board_no);

    int reply_no = mainservice.count_rn(m);

    rb.setId(id);
    rb.setBoard_no(board_no);
    rb.setReply_no(reply_no);
    rb.setReply_id(mb.getId());
    rb.setName(mb.getName());
    rb.setContent(content);
    // 댓글 추가
    mainservice.insertreply(rb);
    // like_date 수정
    mainservice.updatelike_date(m);

    m.put("reply_no", reply_no);

    List<ReplyBean> list = new ArrayList<ReplyBean>();

    list = mainservice.get_reply(m);

    if (!id.equals(sessionid)) {
      // 댓글 알림 등록
      AllimBean allim = new AllimBean();
      allim.setA_flag(a_flag);
      allim.setId(sessionid);
      allim.setAccept_id(id);
      allim.setBoard_no(board_no);
      allim.setReply_no(reply_no);
      mainservice.reply_allim(allim);
    }
    return list;
  }

  // 답글(대댓글) 등록
  @RequestMapping(value = "/re_replyInsert", method = RequestMethod.POST)
  @ResponseBody
  private Object re_replyInsert(HttpServletRequest request, HttpServletResponse response,
      @RequestParam String id, @RequestParam int board_no, @RequestParam String content,
      @RequestParam int re_ref, ReplyBean rb) throws Exception {

    // 세션으로 회원 정보 구하기
    HttpSession session = request.getSession(); // 세션 객체 생성
    String sessionid = (String) session.getAttribute("id");
    MemberBean mb = new MemberBean();
    mb = mainservice.userInfo(sessionid);



    Map m = new HashMap();
    m.put("id", id);
    m.put("board_no", board_no);

    int reply_no = mainservice.count_rn(m);

    System.out.println("re_ref = " + re_ref);
    rb.setRe_ref(re_ref);

    mainservice.refEdit(rb);


    rb.setRe_lev(rb.getRe_lev() + 1);
    rb.setRe_seq(rb.getRe_seq() + 1);
    rb.setContent(content);
    rb.setId(id); /** 수정 **/
    rb.setName(mb.getName());
    rb.setReply_id(mb.getId());
    rb.setReply_no(reply_no);

    mainservice.re_replyInsert(rb);

    mainservice.updatelike_date(m);

    m.put("reply_no", reply_no);

    List<ReplyBean> list = new ArrayList<ReplyBean>();

    list = mainservice.get_reply(m);

    return list;
  }

  // 댓글의 댓글 보기
  @RequestMapping(value = "/re_replyshow", method = RequestMethod.POST)
  @ResponseBody
  private Object re_replyshow(HttpServletRequest request, HttpServletResponse response,
      @RequestParam String id, @RequestParam int board_no, @RequestParam int re_ref,
      @RequestParam(value = "r_r_page", defaultValue = "1", required = false) int r_r_page)
      throws Exception {

    System.out.println("r_r_page = " + r_r_page);

    Map m = new HashMap();
    m.put("id", id);
    m.put("board_no", board_no);
    m.put("re_ref", re_ref);
    m.put("r_r_page", r_r_page);

    List<ReplyBean> list = new ArrayList<ReplyBean>();

    list = mainservice.re_replyshow(m);

    return list;
  }

  // 좋아요 On
  @RequestMapping(value = "/likeStatus", method = RequestMethod.POST)
  @ResponseBody
  private Object likeStatus(HttpServletRequest request, @RequestParam String id,
      @RequestParam int board_no, @RequestParam int a_flag) throws Exception {

    HttpSession session = request.getSession(); // 세션 객체 생성
    String like_id = (String) session.getAttribute("id");

    BoardLikeBean blb = new BoardLikeBean();

    Map m = new HashMap();
    m.put("id", id);
    m.put("board_no", board_no);
    m.put("like_id", like_id);
    int status = 0;

    try {
      status = mainservice.checkboard_like(m);
    } catch (NullPointerException ne) {
      mainservice.updateboard_like(m);
      mainservice.updatelike_date(m);
    }

    if (status == 0) {
      mainservice.updatelike_count(m);
      mainservice.like_status_on(m); // status -> 1

      if (!id.equals(like_id)) {
        // 알림 등록
        AllimBean allim = new AllimBean();
        allim.setA_flag(a_flag);
        allim.setId((String) session.getAttribute("id"));
        allim.setAccept_id(id);
        allim.setBoard_no(board_no);
        mainservice.like_allim(allim);
      }
    } else {
      mainservice.updatelike_count_down(m);
      mainservice.like_status_off(m);// status -> 0
    }
    // 한번더 체크
    status = mainservice.checkboard_like(m);

    return status;
  }

  // 공유하기
  @RequestMapping(value = "/shareboard", method = RequestMethod.POST)
  @ResponseBody
  private Object shareboard(HttpServletRequest request, BoardBean b) throws Exception {

    Map m = new HashMap();
    m.put("id", b.getId());
    m.put("board_no", b.getBoard_no());

    List<BoardBean> list = new ArrayList<BoardBean>();
    list = mainservice.get_board(m);

    return list;

  }

  // 공유하기 insert
  @RequestMapping(value = "/insertshare", method = RequestMethod.POST)
  @ResponseBody
  private Object insertshare(HttpServletRequest request, HttpServletResponse response,
      @RequestParam String id, @RequestParam int board_no, @RequestParam String content)
      throws Exception {


    Map m = new HashMap();
    m.put("id", id);
    m.put("board_no", board_no);

    List<BoardBean> list = new ArrayList<BoardBean>();
    list = mainservice.get_board(m);

    BoardBean b = new BoardBean();

    // 세션으로 회원 정보 구하기
    HttpSession session = request.getSession(); // 세션 객체 생성
    String sessionid = (String) session.getAttribute("id");

    MemberBean mb = new MemberBean();
    mb = mainservice.userInfo(sessionid);
    // 회원 board_no 최대값 구하기
    int sessionboard_no = mainservice.count_bn(sessionid) + 1;

    // 원래 파일명 저장
    b.setBoard_original(list.get(0).getBoard_original());
    // 바뀐 파일명 저장
    b.setBoard_file(list.get(0).getBoard_file());

    b.setId(sessionid);
    b.setBoard_no(sessionboard_no);
    b.setName(mb.getName());
    b.setContent(content);

    mainservice.insertBoard(b);

    Map m2 = new HashMap();
    m2.put("id", sessionid);
    m2.put("board_no", sessionboard_no);
    m2.put("share_id", id);
    m2.put("share_name", list.get(0).getName());
    m2.put("share_no", board_no);
    mainservice.insertshare(m2);

    b.setLike_id(sessionid);
    mainservice.insertBoard_like(b);

    List<FriendListBean> f_list = new ArrayList<FriendListBean>();
    f_list = mainservice.getFriends(sessionid);

    for (int i = 0; i < f_list.size(); i++) {
      b.setLike_id(f_list.get(i).getId2());
      mainservice.insertBoard_like(b);
    }

    return b;
  }

  // 삭제
  @RequestMapping(value = "/deleteboard", method = {RequestMethod.POST, RequestMethod.GET})
  private void deleteboard(HttpServletRequest request, HttpServletResponse response,
      @RequestParam String id, @RequestParam int board_no) throws Exception {

    Map m = new HashMap();
    m.put("id", id);
    m.put("board_no", board_no);

    BoardBean b = mainservice.one_board(m);

    System.out.println("(b.getShare_id() = " + b.getShare_id());

    if (b.getShare_id() == null) {
      try {
        String fnames[] = b.getBoard_file().split("\\|");

        if (fnames[0] != null) {
          for (int i = 0; i < fnames.length; i++) {
            System.out.println("fname = " + i + " = " + fnames[i]);

            File file = new File(saveFolder + fnames[i]);
            file.delete();
          }
        }
      } catch (NullPointerException e) {
        e.printStackTrace();
      } finally {
        this.mainservice.deleteshareboard(m);
      }
    }

    this.mainservice.deleteboard(m);


    response.setContentType("text/html;chaset=UTF-8");
    PrintWriter out = response.getWriter(); // 출력 스트림 객체 생성
    out.println("<script>");
    // out.println("alert('삭제되었습니다.')");
    out.println("location.href='main.nf'");
    out.println("</script>");
    out.close();
  }

  // 친구 ON_OFF
  @RequestMapping(value = "/friend_on_off", method = RequestMethod.POST)
  @ResponseBody
  private Object friend_on_off(@RequestParam("id") String id) throws Exception {

    List<MemberBean> m_list = new ArrayList<MemberBean>();
    m_list = mainservice.getmemberinfo(id);

    return m_list;
  }

  private String getFileDBName(String fileName) throws Exception {
    Calendar c = Calendar.getInstance();
    int year = c.get(Calendar.YEAR); // 오늘 년도 구합니다.
    int month = c.get(Calendar.MONTH) + 1; // 오늘 월 구합니다.
    int date = c.get(Calendar.DATE); // 오늘 일 구합니다.
    /*
     * //아이디 폴더 생성 String idFolder = saveFolder + "/" + id; File path1 = new File(idFolder);
     * if(!(path1.isFile())) System.out.println("파일이 존재하지 않아요."); if(!(path1.exists())) {
     * System.out.println("ID폴더를 만들어요"); path1.mkdir(); //새로운 폴더를 생성 }
     */

    // 날짜 폴더
    // String homedir = saveFolder + "\\" + id + "\\" + year + "-" + month + "-" + date;
    String homedir = saveFolder + "/" + year + "-" + month + "-" + date;
    // homedir에 file 객체 생성
    File path2 = new File(homedir);
    if (!(path2.isFile()))
      System.out.println("파일이 존재하지 않아요.");
    if (!(path2.exists())) {
      System.out.println("날짜폴더를 만들어요");
      path2.mkdir(); // 새로운 폴더를 생성
    }
    /*
     * //board_no 폴더 String boardFolder = saveFolder +
     * "\\" + id + "\\" + year + "-" + month + "-" + date +"\\" + board_no; //homedir에 file 객체 생성
     * File path3 = new File(boardFolder); if(!(path3.isFile()))
     * System.out.println("파일이 존재하지 않아요."); if(!(path3.exists())) {
     * System.out.println("게시판폴더를 만들어요"); path3.mkdir(); //새로운 폴더를 생성 }
     */

    // 난수를 구합니다.
    Random r = new Random();
    int random = r.nextInt(100000000);

    /*** 확장자 구하기 시작 ****/
    int index = fileName.lastIndexOf(".");
    // 문자열에서 특정 문자열의 위치 값(index)를 반환한다.
    // indexOf가 처음 발견되는 문자열에 대한 index를 반환하는 반면,
    // lastIndexOf는 마지막으로 발견되는 문자열의 index를 반환합니다.
    // (파일명에 점에 여러개 있을 경우 맨 마지막에 발견되는 문자열의 위치를 리턴합니다.)
    System.out.println("index = " + index);

    String fileExtension = fileName.substring(index + 1);
    System.out.println("fileExtension = " + fileExtension);
    /**** 확장자 구하기 끝 ****/

    // 새로운 파일명을 만듭니다.
    String refileName = "bbs" + year + month + date + random + "." + fileExtension;
    System.out.println("refileName = " + refileName);

    // 오라클 디비에 저장될 값
    String fileDBName = "/" + year + "-" + month + "-" + date + "/" + refileName;
    System.out.println("fileDBName = " + fileDBName);

    return fileDBName;
  }
}
