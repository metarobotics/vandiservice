package wh;

// 반디 악세서리 (배터리, 액제통 등) 
public class Accessory {
	
	private int accNo;
	private String accId;
	private String accNm;
	private int salesAmt;
	
	private String insertUserId;
	private String insertDatetime;
	private String updateUserId;
	private String updateDatetime;
	
	public Accessory(int accNo, String accId, String accNm, int salesAmt) {
		this.accNo = accNo;
		this.accId = accId;
		this.accNm = accNm;
		this.salesAmt = salesAmt;
	}

	public Accessory(int accNo, String accId, String accNm, int salesAmt, String insertUserId, String insertDatetime,
			String updateUserId, String updateDatetime) {
		super();
		this.accNo = accNo;
		this.accId = accId;
		this.accNm = accNm;
		this.salesAmt = salesAmt;
		this.insertUserId = insertUserId;
		this.insertDatetime = insertDatetime;
		this.updateUserId = updateUserId;
		this.updateDatetime = updateDatetime;
	}
	
	public int getAccNo() {
		return accNo;
	}

	public void setAccNo(int accNo) {
		this.accNo = accNo;
	}

	public String getAccId() {
		return accId;
	}

	public void setAccId(String accId) {
		this.accId = accId;
	}

	public String getAccNm() {
		return accNm;
	}

	public void setAccNm(String accNm) {
		this.accNm = accNm;
	}

	public int getSalesAmt() {
		return salesAmt;
	}

	public void setSalesAmt(int salesAmt) {
		this.salesAmt = salesAmt;
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
