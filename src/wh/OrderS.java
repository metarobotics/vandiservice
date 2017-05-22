package wh;

public class OrderS {

	private int orderNo;
	private String orderDt;
	private int centerNo;
	private String productSerialNo;//4
	private String statusCd;
	private int subtotal;
	private int tax;
	private int totalAmt;
	private int depositPrgAmt;
	private int creditPrgAmt;//10
	private int depositAmt;
	private int creditAmt;
	private int receiptAmt;
	private String note;//14
	
	private String insertUserId;
	private String insertDatetime;
	private String updateUserId;
	private String updateDatetime;//18

	private String centerNm;
	private int clientNo;
	private String clientNm;
	private String statusNm;//22

	public OrderS() {
	}

	public OrderS(int orderNo, String orderDt, int centerNo, String productSerialNo, 
					String statusCd, int subtotal, int tax,	int totalAmt, String insertUserId, String updateUserId) {
		this.orderNo = orderNo;
		this.orderDt = orderDt;
		this.centerNo = centerNo;
		this.productSerialNo = productSerialNo;

		this.statusCd = statusCd;
		this.subtotal = subtotal;
		this.tax = tax;
		this.totalAmt = totalAmt;
		this.insertUserId = insertUserId;
		this.updateUserId = updateUserId;
	}

	// list page 를 보여주기 위한..
	public OrderS(int orderNo, String orderDt, int centerNo, String productSerialNo, 
					String statusCd, int subtotal, int tax, int totalAmt, 
					String insertUserId, String insertDatetime,
					String centerNm, int clientNo, String clientNm, String statusNm) {

		// basic
		this.orderNo = orderNo;
		this.orderDt = orderDt;
		this.centerNo = centerNo;
		this.productSerialNo = productSerialNo;

		this.statusCd = statusCd;
		this.subtotal = subtotal;
		this.tax = tax;
		this.totalAmt = totalAmt;
		this.insertUserId = insertUserId;
		this.insertDatetime = insertDatetime;

		// additional
		this.centerNm = centerNm;
		this.clientNo = clientNo;
		this.clientNm = clientNm;
		this.statusNm = statusNm;
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

	public int getCenterNo() {
		return centerNo;
	}

	public void setCenterNo(int centerNo) {
		this.centerNo = centerNo;
	}

	public String getProductSerialNo() {
		return productSerialNo;
	}

	public void setProductSerialNo(String productSerialNo) {
		this.productSerialNo = productSerialNo;
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

	public String getCenterNm() {
		return centerNm;
	}

	public void setCenterNm(String centerNm) {
		this.centerNm = centerNm;
	}

	public int getClientNo() {
		return clientNo;
	}

	public void setClientNo(int clientNo) {
		this.clientNo = clientNo;
	}

	public String getClientNm() {
		return clientNm;
	}

	public void setClientNm(String clientNm) {
		this.clientNm = clientNm;
	}

	public String getStatusNm() {
		return statusNm;
	}

	public void setStatusNm(String statusNm) {
		this.statusNm = statusNm;
	}

}
