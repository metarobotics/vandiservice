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

	public static String getPOrderNoStr(int orderNo)
	{
		return getOrderNoStr("P", orderNo);
	}

	public static String getClientNoStr(int clientNo)
	{
		return String.format("%7s", clientNo).replace(' ', '0');
	}
	
	public static String getVendorNoStr(int vendorNo)
	{
		return String.format("%7s", vendorNo).replace(' ', '0');
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
	
	public static String FormatCurrentDisplay(int price)
	{
		return NumberFormat.getCurrencyInstance(Locale.KOREA).format(price);
	}

	public static String FormatCurrentDisplay(float price)
	{
		return NumberFormat.getCurrencyInstance(Locale.KOREA).format(price);
	}
	
	// ��14,000, $182.00
	// Currency + Amount
	public static String FormatCurrentDisplay(float price, String curCd)
	{
		if(curCd.equals("WON"))
			return NumberFormat.getCurrencyInstance(Locale.KOREA).format(price);
		else if(curCd.equals("USD"))
			return NumberFormat.getCurrencyInstance(Locale.US).format(price);
		else
			return NumberFormat.getCurrencyInstance(Locale.KOREA).format(price);
	}
	
	// 14000, 182.94
	// Amount only 
	public static String FormatCurrentDisplay2(float price, String curCd)
	{
		if(curCd.equals("WON")){
			String strPrice = new Float(price).toString();
			strPrice = strPrice.substring(0, strPrice.indexOf("."));
			return strPrice;
		}else if(curCd.equals("USD"))
			return NumberFormat.getCurrencyInstance(Locale.US).format(price).toString().substring(1);
		else{
			String strPrice = new Float(price).toString();
			strPrice = strPrice.substring(0, strPrice.indexOf("."));
			return strPrice;
		}
	}

	public static String FormatCurrent(int price)
	{
		return String.valueOf( price );
		//return NumberFormat.getCurrencyInstance(Locale.KOREA).format(price);
	}
	
	public static String FormatCurrent(float price)
	{
		return String.valueOf( price );
		//return NumberFormat.getCurrencyInstance(Locale.KOREA).format(price);
	}
	
	// Caller : ItemDAO
	public static String incoding(String data) throws Exception { 
		
		try {
			
			data = new String(data.getBytes("8859_1"), "euc-kr");
			//data = new String(data.getBytes("KSC5601"), "8859_1");
			
			//sql = new String(",  statusNm ".getBytes("8859_1"), "euc-kr");
			//sql = new String(",  statusNm ".getBytes("KSC5601"), "8859_1");
			
		}catch (Exception e){ 
			e.printStackTrace();
			throw e;
		} 
		return data; 
	} 
}
