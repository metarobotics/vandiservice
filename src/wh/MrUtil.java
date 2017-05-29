package wh;

import java.text.NumberFormat;
import java.util.*;

public class MrUtil {

	public MrUtil()
	{
		
	}
	
	// return : �ֹ����� + �ֹ���ȣ(���� 7�ڸ�) 
	// orderFg : "T", "S", "P"
	private static String getOrderNoStr(String orderFg, int orderNo)
	{
		return orderFg + String.format("%7s", orderNo).replace(' ', '0');
	}
	
	public static String getSOrderNoStr(int orderNo)
	{
		return getOrderNoStr("S", orderNo);
	}

	public static String getTOrderNoStr(int orderNo)
	{
		return getOrderNoStr("T", orderNo);
	}

	public static String getClientNoStr(int clientNo)
	{
		return String.format("%7s", clientNo).replace(' ', '0');
	}
	
	public static String getNoStr2(int no)
	{
		return String.format("%2s", no).replace(' ', '0');
	}
	
	public static String getDateStr()
	{
		// ���糯¥ 
		/*
	     Calendar calendar = Calendar.getInstance(TimeZone.getDefault());
	      //getTime() returns the current date in default time zone
	      Date date = calendar.getTime();
	      int day = calendar.get(Calendar.DATE);
	      //Note: +1 the month for current month
	      int month = calendar.get(Calendar.MONTH) + 1;
	      int year = calendar.get(Calendar.YEAR);
	      int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
	      int dayOfMonth = calendar.get(Calendar.DAY_OF_MONTH);
	      int dayOfYear = calendar.get(Calendar.DAY_OF_YEAR);
	      */
	      
		Calendar now = Calendar.getInstance();
		int dayOfMonth = now.get(Calendar.DATE);
		int month = now.get(Calendar.MONTH)+1;
		String dayOfMonthStr = ((dayOfMonth < 10) ? "0" : "") + dayOfMonth;
		String monthStr = ((month < 10) ? "0" : "") + month;
		String dateStr = now.get(Calendar.YEAR) + "-" + monthStr + "-" + dayOfMonthStr;		
		
		return dateStr;
	}
	
	public static String FormatCurrent(int price)
	{
		return NumberFormat.getCurrencyInstance(Locale.KOREA).format(price);
	}
}
