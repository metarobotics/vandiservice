package wh;

// Product Accessory 
public class ProductAcc {
	
	private int productNo;
	private int accNo;
	private int accCnt;
	
	private String insertUserId;
	private String insertDatetime;
	private String updateUserId;
	private String updateDatetime;
	
	public ProductAcc(int productNo, int accNo, int accCnt) {
		this.productNo = productNo;
		this.accNo = accNo;
		this.accCnt = accCnt;
	}
	
	// for insert 
	public ProductAcc(int productNo, int accNo, int accCnt, String insertUserId) {
		this.productNo = productNo;
		this.accNo = accNo;
		this.accCnt = accCnt;
		this.insertUserId = insertUserId;
	}
	
	public ProductAcc(int productNo, int accNo, int accCnt, String insertUserId, String insertDatetime,
			String updateUserId, String updateDatetime) {
		this.productNo = productNo;
		this.accNo = accNo;
		this.accCnt = accCnt;
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
	public int getAccNo() {
		return accNo;
	}
	public void setAccNo(int accNo) {
		this.accNo = accNo;
	}
	public int getAccCnt() {
		return accCnt;
	}
	public void setAccCnt(int accCnt) {
		this.accCnt = accCnt;
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
