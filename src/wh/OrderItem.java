package wh;

public class OrderItem {
	
	private String orderFg;
	private int orderNo;
	private int seq;
	private int itemNo;
	private int itemCnt;
	private int itemPrice;
	private String insertUserId;
	private String insertDatetime;
	private String updateUserId;
	private String updateDatetime;
		
	public OrderItem() {
	}
	
	public OrderItem(String orderFg, int orderNo, int seq, int itemNo, int itemCnt, int itemPrice, String insertUserId) {
		this.orderFg = orderFg;
		this.orderNo = orderNo;
		this.seq = seq;
		this.itemNo = itemNo;
		this.itemCnt = itemCnt;
		this.itemPrice = itemPrice;
		this.insertUserId = insertUserId;
	}

	public String getOrderFg() {
		return orderFg;
	}

	public void setOrderFg(String orderFg) {
		this.orderFg = orderFg;
	}

	public int getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public int getItemNo() {
		return itemNo;
	}

	public void setItemNo(int itemNo) {
		this.itemNo = itemNo;
	}

	public int getItemCnt() {
		return itemCnt;
	}

	public void setItemCnt(int itemCnt) {
		this.itemCnt = itemCnt;
	}

	public int getItemPrice() {
		return itemPrice;
	}

	public void setItemPrice(int itemPrice) {
		this.itemPrice = itemPrice;
	}

	public String getInsertUserId() {
		return insertUserId;
	}

	public void setInsertUserId(String insertUserId) {
		this.insertUserId = insertUserId;
	}

	public String getInsertDatetime() {
		return insertDatetime;
	}

	public void setInsertDatetime(String insertDatetime) {
		this.insertDatetime = insertDatetime;
	}

	public String getUpdateUserId() {
		return updateUserId;
	}

	public void setUpdateUserId(String updateUserId) {
		this.updateUserId = updateUserId;
	}

	public String getUpdateDatetime() {
		return updateDatetime;
	}

	public void setUpdateDatetime(String updateDatetime) {
		this.updateDatetime = updateDatetime;
	}

}

