package com.newface.pro.dao;

import java.util.List;
import java.util.Map;

import com.newface.pro.model.AllimBean;

public interface AllimService {
  // 알람 리스트 가져오기
  public List<AllimBean> getAllim_list(Map<String, Object> m);

  // 알림 드롭 다운 시 목록 조회
  public List<AllimBean> getAllim_dropdown_list(Map<String, Object> m);

  // 알림 리스트 추가
  public List<AllimBean> getAllim_list_plus(Map<String, Object> m);

  // 새 알림 개수 체크
  public int getAllim_count_check(String id);


}
