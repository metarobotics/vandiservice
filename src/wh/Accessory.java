package wh;

// 반디 악세서리 (배터리, 액제통 등) 
public class Accessory {
	
	private int accNo;
	private String accId;
	private String accNm;
	private int salesAmt;
	
	public Accessory(int accNo, String accId, String accNm, int salesAmt) {
		this.accNo = accNo;
		this.accId = accId;
		this.accNm = accNm;
		this.salesAmt = salesAmt;
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
	
	
}
