package wh;

public class OrderSItem {
	
	private int orderNo;
	private int seq;
	private int itemNo;
	private int itemCnt;
	private int itemPrice;//5 ¿øÈ­ 
	private float serviceHour;
	
	private String insertUserId; //7
	private String insertDatetime;
	private String updateUserId;
	private String updateDatetime;
		
	public OrderSItem() {
	}
	
	public OrderSItem(int orderNo, int seq, int itemNo, int itemCnt, int itemPrice, float serviceHour, String insertUserId) {
		this.orderNo = orderNo;
		this.seq = seq;
		this.itemNo = itemNo;
		this.itemCnt = itemCnt;
		this.itemPrice = itemPrice;
		this.serviceHour = serviceHour;
		this.insertUserId = insertUserId;
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

	public float getItemPrice() {
		return itemPrice;
	}

	public void setItemPrice(int itemPrice) {
		this.itemPrice = itemPrice;
	}
	
	public float getServiceHour() {
		//System.out.println("[ServiceHour]" + this.itemNo + "/" + this.serviceHour);
		return serviceHour;
	}

	public void setServiceHour(float serviceHour) {
		this.serviceHour = serviceHour;
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

