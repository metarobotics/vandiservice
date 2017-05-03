package wh;

public class Item {
	
	private int itemNo;
	private String itemNm;
	private int insertUserNo;
	private String insertDatetime;
	
	public Item() {
	}
	
	public Item(int itemNo, String itemNm, int insertUserNo, String insertDatetime) {
		this.itemNo = itemNo;
		this.itemNm = itemNm;
		this.insertUserNo = insertUserNo;
		this.insertDatetime = insertDatetime;
	}

	public int getItemNo() {
		return itemNo;
	}

	public void setItemNo(int itemNo) {
		this.itemNo = itemNo;
	}

	public String getItemNm() {
		return itemNm;
	}

	public void setItemNm(String itemNm) {
		this.itemNm = itemNm;
	}
	
	public int getInsertUserNo() {
		return insertUserNo;
	}

	public void setInsertUserNo(int insertUserNo) {
		this.insertUserNo = insertUserNo;
	}

	public String getInsertDatetime() {
		return insertDatetime;
	}

	public void setInsertDatetime(String insertDatetime) {
		this.insertDatetime = insertDatetime;
	}
	
}

