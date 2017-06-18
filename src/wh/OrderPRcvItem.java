package wh;

public class OrderPRcvItem {
	
	private int orderNo;
	private int rcvSeq;
	private int seq;
	private int itemNo;
	private int itemCnt;
	
	private String insertUserId; 
	private String insertDatetime;
	private String updateUserId;
	private String updateDatetime;
		
	public OrderPRcvItem() {
	}
	
	public OrderPRcvItem(int orderNo, int rcvSeq, int seq, int itemNo, int itemCnt, String insertUserId, String updateUserId) {
		this.orderNo = orderNo;
		this.rcvSeq = rcvSeq;
		this.seq = seq;
		this.itemNo = itemNo;
		this.itemCnt = itemCnt;
		
		this.insertUserId = insertUserId;
		this.updateUserId = updateUserId;
	}

	public int getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}

	public int getRcvSeq() {
		return rcvSeq;
	}

	public void setRcvSeq(int rcvSeq) {
		this.rcvSeq = rcvSeq;
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

