package com.ivucenter.cloud.portal.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.TimeZone;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DateUtils extends org.apache.commons.lang.time.DateUtils {

    private static final Logger logger = LoggerFactory.getLogger(DateUtils.class);

    /* convert UTC time into Date */
	public static Date convertUtcToDate(String str) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssZ");

		try {
			return format.parse(str.replaceAll("Z$", "+0000"));
		} catch (ParseException e) {
			logger.error("convertUtcToDate ParseException");
		}

		return null;
	}

	/*************************************************************
	 *** convertStringToDate
	 *** 		String date : 입력일자
	 ***		String timezone : 시간대 (Asia/Seoul, Greenwitch 등)
	 ***		String format : yyyy-MM-dd HH:mm:ss
	 *** Example
	 ***        String strTime = "2017-06-26T01:00:00+00:00";
     ***		Date date2 = DateUtils.convertStringToDate(strTime, "Greenwitch", "yyyy-MM-dd'T'HH:mm:ssXXX");
	 *************************************************************/
	public static Date convertStringToDate(String date, String timezone, String format) {
        DateFormat df = new SimpleDateFormat(format);
        TimeZone tz= TimeZone.getTimeZone(timezone);
        df.setTimeZone(tz);
        try {
			return df.parse(date);
		} catch (ParseException e) {
			logger.error("convertStringToDate ParseException");
		}
		return null;
	}

	/*************************************************************
	 *** convertDateToString
	 *** 		Date date : 입력일자
	 ***		String timezone : 시간대 (Asia/Seoul, Greenwitch 등)
	 ***		String format : yyyy-MM-dd HH:mm:ss
	 *** Example
	 ***        String gmt = DateUtils.convertDateToString(date, " Greenwitch", "yyyy-MM-dd'T'HH:mm:ss");
     ***		String seoul = DateUtils.convertDateToString(date, "Asia/Seoul", "yyyy-MM-dd HH:mm:ss");
	 *************************************************************/
	public static String convertDateToString(Date date, String timezone, String format) {
        DateFormat df = new SimpleDateFormat(format);
        TimeZone tz= TimeZone.getTimeZone(timezone);
        df.setTimeZone(tz);
        return df.format(date);
	}


	/*************************************************************
	 * diffDays
	 * @param begin
	 * @param end
	 * @return
	 * 		두 날짜사이의 일수를 계산하여 리턴한다.
	 *************************************************************/
	public static long diffDays(Date begin, Date end) {
		long diff = end.getTime() - begin.getTime();
		long diffDays = diff / (24 * 60 * 60 * 1000);

		return diffDays;
	}

	/*************************************************************
	 * diffHours
	 * @param begin
	 * @param end
	 * @return
	 * 		두 날짜사이의 시간을 계산하여 리턴한다.
	 *************************************************************/
	public static long diffHours(Date begin, Date end) {
		long diff = end.getTime() - begin.getTime();
		long diffHours = diff / (60 * 60 * 1000);

		return diffHours;
	}

	public static int lastDayOfMonth(int year, int month) {
		Calendar cal = Calendar.getInstance();
		cal.set(year, month-1, 1);

		return cal.getActualMaximum(Calendar.DAY_OF_MONTH);
	}

	public static int getYear(Date date) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);

		return cal.get(Calendar.YEAR);
	}

	public static int getMonth(Date date) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);

		return cal.get(Calendar.MONTH) + 1;
	}

	public static int getDay(Date date) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);

		return cal.get(Calendar.DAY_OF_MONTH);
	}
}
