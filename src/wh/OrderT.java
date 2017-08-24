package wh;

public class OrderT {

	private int orderNo;
	private String orderDt;
	private int srcWhNo;
	private int destWhNo;
	private String deliverPrgDt;
	private String delieverDt;
	private String statusCd;
	private int subtotal;
	private int tax;
	private int totalAmt;
	private int depositPrgAmt;
	private int creditPrgAmt;
	private int depositAmt;
	private int creditAmt;
	private int receiptAmt;
	private String note;
	private String insertUserId;
	private String insertDatetime;
	private String updateUserId;
	private String updateDatetime;

	private String srcWhNm;
	private String destWhNm;
	private String statusNm;

	public OrderT() {
	}

	//sql = "select orderNo, orderDt, srcWhNo, destWhNo, statusCd, subtotal, tax, totalAmt, note, insertUserId, updateUserId from orderT where orderNo = ?"; 
	public OrderT(int orderNo, String orderDt, int srcWhNo, int destWhNo,
					String statusCd, int subtotal, int tax, int totalAmt, String note, String insertUserId, String updateUserId) {
		this.orderNo = orderNo;
		this.orderDt = orderDt;
		this.srcWhNo = srcWhNo;
		this.destWhNo = destWhNo;

		this.statusCd = statusCd;
		this.subtotal = subtotal;
		this.tax = tax;
		this.totalAmt = totalAmt;
		this.note = note;
		
		this.insertUserId = insertUserId;
		this.updateUserId = updateUserId;
	}

	// list page 를 보여주기 위한..
	public OrderT(int orderNo, String orderDt, int srcWhNo, int destWhNo, 
					String statusCd, int subtotal, int tax, int totalAmt, String insertUserId, String note, 
					String srcWhNm, String destWhNm, String statusNm) {

		// basic
		this.orderNo = orderNo;
		this.orderDt = orderDt;
		this.srcWhNo = srcWhNo;
		this.destWhNo = destWhNo;

		this.statusCd = statusCd;
		this.subtotal = subtotal;
		this.tax = tax;
		this.totalAmt = totalAmt;
		this.insertUserId = insertUserId;

		// additional
		this.srcWhNm = srcWhNm;
		this.destWhNm = destWhNm;
		this.statusNm = statusNm;
		this.note = note;
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

	public int getSrcWhNo() {
		return srcWhNo;
	}

	public void setSrcWhNo(int srcWhNo) {
		this.srcWhNo = srcWhNo;
	}

	public int getDestWhNo() {
		return destWhNo;
	}

	public void setDestWhNo(int destWhNo) {
		this.destWhNo = destWhNo;
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

	public int getSubtotal() {
		return subtotal;
	}

	public void setSubtotal(int subtotal) {
		this.subtotal = subtotal;
	}

	public int getTax() {
		return tax;
	}

	public void setTax(int tax) {
		this.tax = tax;
	}

	public int getTotalAmt() {
		return totalAmt;
	}

	public void setTotalAmt(int totalAmt) {
		this.totalAmt = totalAmt;
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

	public String getSrcWhNm() {
		return srcWhNm;
	}

	public void setSrcWhNm(String srcWhNm) {
		this.srcWhNm = srcWhNm;
	}

	public String getDestWhNm() {
		return destWhNm;
	}

	public void setDestWhNm(String destWhNm) {
		this.destWhNm = destWhNm;
	}

	public String getStatusNm() {
		return statusNm;
	}

	public void setStatusNm(String statusNm) {
		this.statusNm = statusNm;
	}

}
