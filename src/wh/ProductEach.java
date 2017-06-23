package wh;

public class ProductEach {
	
	private int productEachNo;
	private int productNo;
	private String serialNo;
	private String prodDt;
	private String certDt;
	private String registerNo;
	private int clientNo;//7
	
	private String insertUserId;
	private String insertDatetime;
	private String updateUserId;
	private String updateDatetime;//11
	
	private String clientNm;
	private String clientLocation;

	
	public ProductEach() {
	}

	public ProductEach(int productEachNo, int productNo, String serialNo, String prodDt, String certDt, String registerNo, int clientNo, 
			String insertUserId, String insertDatetime, String updateUserId, String updateDatetime) {
	
		this.productEachNo = productEachNo;
		this.productNo = productNo;
		this.serialNo = serialNo;
		this.prodDt = prodDt;
		this.certDt = certDt;
		this.registerNo = registerNo;
		this.clientNo = clientNo;
		
		this.insertUserId = insertUserId;
		this.insertDatetime = insertDatetime;
		this.updateUserId = updateUserId;
		this.updateDatetime = updateDatetime;
		
	}
	
	public ProductEach(int productEachNo, int productNo, String serialNo, String prodDt, String certDt, String registerNo, int clientNo, 
					String insertUserId, String insertDatetime, String updateUserId, String updateDatetime,
					String clientNm, String clientLocation) {
		
		this.productEachNo = productEachNo;
		this.productNo = productNo;
		this.serialNo = serialNo;
		this.prodDt = prodDt;
		this.certDt = certDt;
		this.registerNo = registerNo;
		this.clientNo = clientNo;
		
		this.insertUserId = insertUserId;
		this.insertDatetime = insertDatetime;
		this.updateUserId = updateUserId;
		this.updateDatetime = updateDatetime;
		
		this.clientNm = clientNm;
		this.clientLocation = clientLocation;
	}

	public int getProductEachNo() {
		return productEachNo;
	}

	public void setProductEachNo(int productEachNo) {
		this.productEachNo = productEachNo;
	}

	public int getProductNo() {
		return productNo;
	}

	public void setProductNo(int productNo) {
		this.productNo = productNo;
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
}

