package wh;

public class Product {
	
	private int productNo;//1
	
	private String productId;//2
	private String productNmKor;
	private String productNmEng;
	private String createDt;//5
	
	private String insertUserId;//6
	private String insertDatetime;
	private String updateUserId;
	private String updateDatetime;//9
	
	public Product() {
	}
	
	public Product(int productNo, String productId, String productNmKor, String productNmEng, String createDt, 
					String insertUserId, String insertDatetime, String updateUserId, String updateDatetime) {
		
		this.productNo = productNo;
		
		this.productId = productId;
		this.productNmKor = productNmKor;
		this.productNmEng = productNmEng;
		this.createDt = createDt;
		
		this.insertUserId = insertUserId;
		this.insertDatetime = insertDatetime;
		this.updateUserId = updateUserId;
		this.updateDatetime = updateDatetime;
	}

	public int getProductNo() {
		return productNo;
	}

	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}

	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}

	public String getProductNmKor() {
		return productNmKor;
	}

	public void setProductNmKor(String productNmKor) {
		this.productNmKor = productNmKor;
	}

	public String getProductNmEng() {
		return productNmEng;
	}

	public void setProductNmEng(String productNmEng) {
		this.productNmEng = productNmEng;
	}

	public String getCreateDt() {
		return createDt;
	}

	public void setCreateDt(String createDt) {
		this.createDt = createDt;
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

