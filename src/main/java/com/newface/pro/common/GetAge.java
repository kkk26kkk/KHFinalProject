package com.newface.pro.common;

import java.util.Calendar;

public class GetAge {
  public static String getM_age(String birth) {
    Calendar c = Calendar.getInstance();
    int year1 = c.get(Calendar.YEAR);
    int year2 = Integer.parseInt(birth.substring(0, 4));

    int age = ((year1 - year2 + 1) / 10) * 10;

    return age + "대";
  }

  public static String getAge(String birth) {
    Calendar c = Calendar.getInstance();

    int mem_birth_year = Integer.parseInt(birth);
    int current_year = c.get(Calendar.YEAR);
    int mem_age = current_year - mem_birth_year + 1;

    return mem_age + "세";
  }
}
