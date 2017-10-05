package wh;

public class Product {
	
	private int productNo;
	private int modelNo;
	private String serialNo;
	private String prodDt;
	private String certDt;
	private String registerNo;
	private int clientNo;//7
	
	// 2017.10. 8°³ Ãß°¡ 
	private int productCost;
	private String salesDt;
	private int salesAmt;
	private int  addSalesAmt;
	private String payDt;
	private int  payAmt;
	private int creditSalesAmt;
	private String note;
	
	private String insertUserId;
	private String insertDatetime;
	private String updateUserId;
	private String updateDatetime;//11
	
	private String clientNm;
	private String clientLocation;

	
	public Product() {
	}

	public Product(int productNo, int modelNo, String serialNo, String prodDt, String certDt, String registerNo, int clientNo, 
			int productCost, String salesDt, int salesAmt, int addSalesAmt, String payDt, int payAmt, int creditSalesAmt, String note, 
			String insertUserId, String insertDatetime, String updateUserId, String updateDatetime) {
	
		this.productNo = productNo;
		this.modelNo = modelNo;
		this.serialNo = serialNo;
		this.prodDt = prodDt;
		this.certDt = certDt;
		this.registerNo = registerNo;
		this.clientNo = clientNo;
		
		this.productCost = productCost;
		this.salesDt = salesDt;
		this.salesAmt = salesAmt;
		this.addSalesAmt = addSalesAmt;
		this.payDt = payDt;
		this.payAmt = payAmt;
		this.creditSalesAmt = creditSalesAmt;
		this.note = note;
		
		this.insertUserId = insertUserId;
		this.insertDatetime = insertDatetime;
		this.updateUserId = updateUserId;
		this.updateDatetime = updateDatetime;
		
	}
	
	public Product(int productNo, int modelNo, String serialNo, String prodDt, String certDt, String registerNo, int clientNo, 
					int productCost, String salesDt, int salesAmt, int addSalesAmt, String payDt, int payAmt, int creditSalesAmt, String note, 
					String insertUserId, String insertDatetime, String updateUserId, String updateDatetime,
					String clientNm, String clientLocation) {
		
		this.productNo = productNo;
		this.modelNo = modelNo;
		this.serialNo = serialNo;
		this.prodDt = prodDt;
		this.certDt = certDt;
		this.registerNo = registerNo;
		this.clientNo = clientNo;
		
		this.productCost = productCost;
		this.salesDt = salesDt;
		this.salesAmt = salesAmt;
		this.addSalesAmt = addSalesAmt;
		this.payDt = payDt;
		this.payAmt = payAmt;
		this.creditSalesAmt = creditSalesAmt;
		this.note = note;
		
		this.insertUserId = insertUserId;
		this.insertDatetime = insertDatetime;
		this.updateUserId = updateUserId;
		this.updateDatetime = updateDatetime;
		
		this.clientNm = clientNm;
		this.clientLocation = clientLocation;
	}

	public int getProductNo() {
		return productNo;
	}

	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}

	public int getModelNo() {
		return modelNo;
	}

	public void setModelNo(int modelNo) {
		this.modelNo = modelNo;
	}

	public String getSerialNo() {
		return serialNo;
	}

	public void setSerialNo(String serialNo) {
		this.serialNo = serialNo;
	}

	public String getProdDt() {
		return prodDt;
	}

	public void setProdDt(String prodDt) {
		this.prodDt = prodDt;
	}

	public String getCertDt() {
		return certDt;
	}

	public void setCertDt(String certDt) {
		this.certDt = certDt;
	}

	public String getRegisterNo() {
		return registerNo;
	}

	public void setRegisterNo(String registerNo) {
		this.registerNo = registerNo;
	}

	public int getClientNo() {
		return clientNo;
	}

	public void setClientNo(int clientNo) {
		this.clientNo = clientNo;
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

	public String getClientNm() {
		return clientNm;
	}

	public void setClientNm(String clientNm) {
		this.clientNm = clientNm;
	}

	public String getClientLocation() {
		return clientLocation;
	}

	public int getProductCost() {
		return productCost;
	}

	public void setProductCost(int productCost) {
		this.productCost = productCost;
	}

	public String getSalesDt() {
		return salesDt;
	}

	public void setSalesDt(String salesDt) {
		this.salesDt = salesDt;
	}

	public int getSalesAmt() {
		return salesAmt;
	}

	public void setSalesAmt(int salesAmt) {
		this.salesAmt = salesAmt;
	}

	public int getAddSalesAmt() {
		return addSalesAmt;
	}

	public void setAddSalesAmt(int addSalesAmt) {
		this.addSalesAmt = addSalesAmt;
	}

	public String getPayDt() {
		return payDt;
	}

	public void setPayDt(String payDt) {
		this.payDt = payDt;
	}

	public int getPayAmt() {
		return payAmt;
	}

	public void setPayAmt(int payAmt) {
		this.payAmt = payAmt;
	}

	public int getCreditSalesAmt() {
		return creditSalesAmt;
	}

	public void setCreditSalesAmt(int creditSalesAmt) {
		this.creditSalesAmt = creditSalesAmt;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}
}

