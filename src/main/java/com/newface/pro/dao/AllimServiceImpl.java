package com.newface.pro.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.newface.pro.model.AllimBean;

@Service
public class AllimServiceImpl implements AllimService {
  @Autowired
  private AllimDAOImpl allimDAO;

  // 알람 리스트 가져오기
  @Override
  public List<AllimBean> getAllim_list(Map<String, Object> m) {
    return allimDAO.getAllim_list(m);
  }

  // 알림 드롭 다운 시 목록 조회
  @Override
  public List<AllimBean> getAllim_dropdown_list(Map<String, Object> m) {
    return allimDAO.getAllim_dropdown_list(m);
  }

  // 알림 리스트 추가
  @Override
  public List<AllimBean> getAllim_list_plus(Map<String, Object> m) {
    return allimDAO.getAllim_list_plus(m);
  }

  // 새 알림 개수 체크
  @Override
  public int getAllim_count_check(String id) {
    return allimDAO.getAllim_count_check(id);
  }

}
