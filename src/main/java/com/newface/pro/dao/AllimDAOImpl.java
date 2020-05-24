package com.newface.pro.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.newface.pro.model.AllimBean;

@Repository
public class AllimDAOImpl {
  @Autowired
  private SqlSessionTemplate sqlSession;

  // 알림 리스트 가져오기
  public List<AllimBean> getAllim_list(Map<String, Object> m) {
    return sqlSession.selectList("getAllim_all_list", m);
  }

  // 알림 드롭 다운 시 목록 조회
  public List<AllimBean> getAllim_dropdown_list(Map<String, Object> m) {
    return sqlSession.selectList("getAllim_dropdown_list", m);
  }

  // 알림 리스트 추가
  public List<AllimBean> getAllim_list_plus(Map<String, Object> m) {
    return sqlSession.selectList("getAllim_list_plus", m);
  }

  // 새 알림 개수 체크
  public int getAllim_count_check(String id) {
    return sqlSession.selectOne("getAllim_count_check", id);
  }

}
