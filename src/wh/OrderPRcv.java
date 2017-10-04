package wh;

public class OrderPRcv {

	private int orderNo;
	private int rcvSeq;
	private String rcvDt;
	private String note;
	private String insertUserId;
	private String insertDatetime;
	private String updateUserId;
	private String updateDatetime;
	
	private int whNo;
	
	public OrderPRcv()
	{
		
	}
	
	public OrderPRcv(int orderNo, int rcvSeq, String rcvDt, String note, String insertUserId, String updateUserId)
	{
		this.orderNo = orderNo;
		this.rcvSeq = rcvSeq;
		this.rcvDt = rcvDt;
		this.note = note;
		
		this.insertUserId = insertUserId;
		this.updateUserId = updateUserId;
	}
	
	public OrderPRcv(int orderNo, int rcvSeq, String rcvDt, String note, int whNo, String insertUserId, String updateUserId)
	{
		this.orderNo = orderNo;
		this.rcvSeq = rcvSeq;
		this.rcvDt = rcvDt;
		this.note = note;
		
		this.whNo = whNo;
		
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
	public String getRcvDt() {
		return rcvDt;
	}
	public void setRcvDt(String rcvDt) {
		this.rcvDt = rcvDt;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
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
	
	public int getWhNo() {
		return whNo;
	}

	public void setWhNo(int whNo) {
		this.whNo = whNo;
	}
	
	
}
