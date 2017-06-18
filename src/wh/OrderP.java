package wh;

public class OrderP {

	private int orderNo;
	private String orderDt;
	private int whNo;
	private String deliverPrgDt;
	private String delieverDt;//5
	private String statusCd;
	private float subtotal;
	private float tax;
	private float totalAmt;//9
	private String curCd;//10
	private int depositPrgAmt;//11
	private int creditPrgAmt;
	private int depositAmt;
	private int creditAmt;
	private int receiptAmt;
	private String note;//16
	private String insertUserId;//17
	private String insertDatetime;
	private String updateUserId;//19
	private String updateDatetime;//20

	private String whNm;//21
	private String statusNm;
	private int rcvCnt; // 입고처리건수
	
	public OrderP() {
	}

	public OrderP(int orderNo, String orderDt, int whNo, 
					String statusCd, float subtotal, float tax, float totalAmt, String curCd, String insertUserId, String updateUserId) {
		this.orderNo = orderNo;
		this.orderDt = orderDt;
		this.whNo = whNo;

		this.statusCd = statusCd;
		this.subtotal = subtotal;
		this.tax = tax;
		this.totalAmt = totalAmt;
		this.curCd = curCd;
		this.insertUserId = insertUserId;
		this.updateUserId = updateUserId;
	}

	// list page 를 보여주기 위한..
	public OrderP(int orderNo, String orderDt, int whNo, 
					String statusCd, float subtotal, float tax, float totalAmt, String curCd, String insertUserId, String updateUserId, 
					String whNm, String statusNm, int rcvCnt) {

		// basic
		this.orderNo = orderNo;
		this.orderDt = orderDt;
		this.whNo = whNo;

		this.statusCd = statusCd;
		this.subtotal = subtotal;
		this.tax = tax;
		this.totalAmt = totalAmt;
		this.curCd = curCd;
		this.insertUserId = insertUserId;
		this.updateUserId = updateUserId;

		// additional
		this.whNm = whNm;
		this.statusNm = statusNm;
		this.rcvCnt = rcvCnt;
	}

	public int getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}

	public String getOrderDt() {
		return orderDt;
	}

	public void setOrderDt(String orderDt) {
		this.orderDt = orderDt;
	}

	public int getWhNo() {
		return whNo;
	}

	public void setWhNo(int whNo) {
		this.whNo = whNo;
	}

	public String getDeliverPrgDt() {
		return deliverPrgDt;
	}

	public void setDeliverPrgDt(String deliverPrgDt) {
		this.deliverPrgDt = deliverPrgDt;
	}

	public String getDelieverDt() {
		return delieverDt;
	}

	public void setDelieverDt(String delieverDt) {
		this.delieverDt = delieverDt;
	}

	public String getStatusCd() {
		return statusCd;
	}

	public void setStatusCd(String statusCd) {
		this.statusCd = statusCd;
	}

	public float getSubtotal() {
		return subtotal;
	}

	public void setSubtotal(float subtotal) {
		this.subtotal = subtotal;
	}

	public float getTax() {
		return tax;
	}

	public void setTax(float tax) {
		this.tax = tax;
	}

	public float getTotalAmt() {
		return totalAmt;
	}

	public void setTotalAmt(float totalAmt) {
		this.totalAmt = totalAmt;
	}

	public String getCurCd() {
		return curCd;
	}

	public void setCurCd(String curCd) {
		this.curCd = curCd;
	}

	public int getDepositPrgAmt() {
		return depositPrgAmt;
	}

	public void setDepositPrgAmt(int depositPrgAmt) {
		this.depositPrgAmt = depositPrgAmt;
	}

	public int getCreditPrgAmt() {
		return creditPrgAmt;
	}

	public void setCreditPrgAmt(int creditPrgAmt) {
		this.creditPrgAmt = creditPrgAmt;
	}

	public int getDepositAmt() {
		return depositAmt;
	}

	public void setDepositAmt(int depositAmt) {
		this.depositAmt = depositAmt;
	}

	public int getCreditAmt() {
		return creditAmt;
	}

	public void setCreditAmt(int creditAmt) {
		this.creditAmt = creditAmt;
	}

	public int getReceiptAmt() {
		return receiptAmt;
	}

	public void setReceiptAmt(int receiptAmt) {
		this.receiptAmt = receiptAmt;
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

	public String getWhNm() {
		return whNm;
	}

	public void setWhNm(String whNm) {
		this.whNm = whNm;
	}

	public String getStatusNm() {
		return statusNm;
	}

	public void setStatusNm(String statusNm) {
		this.statusNm = statusNm;
	}

	public int getRcvCnt() {
		return rcvCnt;
	}

	public void setRcvCnt(int rcvCnt) {
		this.rcvCnt = rcvCnt;
	}

}
