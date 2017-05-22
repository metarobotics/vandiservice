package wh;

public class ProductItem {
	
	private int productNo;
	private String itemId;
	private int itemCnt;

	private String insertUserId;
	private String insertDatetime;
	private String updateUserId;
	private String updateDatetime;

	// join columns
	private String itemNm;
	private String itemNmKr;
	
	
	public ProductItem() {
	}
	
	public ProductItem(int productNo, String itemId, int itemCnt, 
					String insertUserId, String insertDatetime, String updateUserId, String updateDatetime,
					String itemNm, String itemNmKr) {
		
		this.productNo = productNo;
		this.itemId = itemId;
		this.itemCnt = itemCnt;
		
		this.itemNm = itemNm;
		this.itemNmKr = itemNmKr;

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

	public String getItemId() {
		return itemId;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}

	public int getItemCnt() {
		return itemCnt;
	}

	public void setItemCnt(int itemCnt) {
		this.itemCnt = itemCnt;
	}

	public String getItemNm() {
		return itemNm;
	}

	public void setItemNm(String itemNm) {
		this.itemNm = itemNm;
	}

	public String getItemNmKr() {
		return itemNmKr;
	}

	public void setItemNmKr(String itemNmKr) {
		this.itemNmKr = itemNmKr;
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

