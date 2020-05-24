package com.newface.pro.common;

public class TIME_MAXIMUM {
  public static final int SEC = 60;
  public static final int MIN = 60;
  public static final int HOUR = 24;
  public static final int DAY = 30;
  public static final int MONTH = 12;

  public static String formatTimeString(long regDate, long currentDate) {
    long diffTime = (currentDate - regDate) / 1000;

    String msg = "";
    if (diffTime < TIME_MAXIMUM.SEC) { // sec
      msg = "방금 전";
    } else if ((diffTime /= TIME_MAXIMUM.SEC) < TIME_MAXIMUM.MIN) { // min
      msg = diffTime + "분 전";
    } else if ((diffTime /= TIME_MAXIMUM.MIN) < TIME_MAXIMUM.HOUR) { // hour
      msg = (diffTime) + "시간 전";
    } else if ((diffTime /= TIME_MAXIMUM.HOUR) < TIME_MAXIMUM.DAY) { // day
      msg = (diffTime) + "일 전";
    } else if ((diffTime /= TIME_MAXIMUM.DAY) < TIME_MAXIMUM.MONTH) { // month
      msg = (diffTime) + "달 전";
    } else { // year
      msg = (diffTime) + "년 전";
    }

    return msg;
  }
}
