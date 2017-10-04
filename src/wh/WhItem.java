package wh;

public class WhItem {

	private int whNo;
	private int itemNo;
	private int itemCnt;
	
	private String insertUserId;
	private String insertDatetime;
	private String updateUserId;
	private String updateDatetime;
	
	public WhItem(){
		
	}
	
	public WhItem(int whNo, int itemNo, int itemCnt, String insertUserId, String updateUserId) {
		this.whNo = whNo;
		this.itemNo = itemNo;
		this.itemCnt = itemCnt;
		this.insertUserId = insertUserId;
		this.updateUserId = updateUserId;
	}
	

	public int getWhNo() {
		return whNo;
	}

	public void setWhNo(int whNo) {
		this.whNo = whNo;
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
