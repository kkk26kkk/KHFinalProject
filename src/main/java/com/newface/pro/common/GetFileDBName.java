package com.newface.pro.common;

import java.io.File;
import java.util.Calendar;
import java.util.Random;

public class GetFileDBName {
  public String profileImageFolder =
      "C:\\Users\\user1\\git\\FinalProject\\FinalProject\\src\\main\\webapp\\resources\\upload\\profileimg";
  public String backgroundImageFolder =
      "C:\\Users\\user1\\git\\FinalProject\\FinalProject\\src\\main\\webapp\\resources\\upload\\backgroundimg";

  public String getFileDBName(String fileName, int flag) {
    Calendar c = Calendar.getInstance();
    int year = c.get(Calendar.YEAR);
    int month = c.get(Calendar.MONTH) + 1;
    int date = c.get(Calendar.DATE);

    String imgDir = "";
    if (flag == 1) // 프로필 사진인 경우
      imgDir = profileImageFolder + "/" + year + "-" + month + "-" + date;
    else if (flag == 2) { // 배경 사진인 경우
      imgDir = backgroundImageFolder + "/" + year + "-" + month + "-" + date;
    }

    // 해당 폴더에 file 객체 생성
    File path1 = new File(imgDir);

    if (!path1.isFile())
      System.out.println("파일이 존재하지 않아요.");
    if (!path1.exists()) {
      System.out.println("폴더 만들어요");
      path1.mkdir();
    }

    // 난수 구하기
    Random r = new Random();
    int random = r.nextInt(100000000);

    /* 확장자 구하기 */
    int index = fileName.lastIndexOf(".");

    String fileExtension = fileName.substring(index + 1);
    /* 확장자 구하기 끝 */

    // 새로운 파일명 생성
    String refileName = "";
    if (flag == 1) // 프로필 사진인 경우
      refileName = "profile" + year + month + random + "." + fileExtension;
    else if (flag == 2) // 배경사진인 경우
      refileName = "background" + year + month + random + "." + fileExtension;

    // 오라클 db에 저장될 파일명
    String fileDBName = "/" + year + "-" + month + "-" + date + "/" + refileName;

    return fileDBName;
  }
}
