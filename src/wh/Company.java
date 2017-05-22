package wh;

public class Company {
	
	private int companyNo;//i1
	
	private String companyId;//s1
	private String companyNm;
	private String ceoNm;
	private String phoneNo;
	private String mobileNo;
	private String faxNo;
	private String email;
	private String addr;
	private String acntBankNm;
	private String acntNo;//s10
	
	private String acntUserNm;
	private String insertUserId;
	private String insertDatetime;
	private String updateUserId;
	private String updateDatetime;//s15
	
	private int dealCnt; //거래건수 
	
	public Company() {
	}
	
	public Company(int companyNo, String companyId, String companyNm, String ceoNm, String phoneNo, String mobileNo, String faxNo, String email, String addr, String acntBankNm, String acntNo, 
					String acntUserNm, String insertUserId, String insertDatetime, String updateUserId, String updateDatetime) {
		this.companyNo = companyNo;
		
		this.companyId = companyId;
		this.companyNm = companyNm;
		this.ceoNm = ceoNm;
		this.phoneNo = phoneNo;
		this.mobileNo = mobileNo;
		this.faxNo = faxNo;
		this.email = email;
		this.addr = addr;
		this.acntBankNm = acntBankNm;
		this.acntNo = acntNo;
		
		this.acntUserNm = acntUserNm;
		this.insertUserId = insertUserId;
		this.insertDatetime = insertDatetime;
		this.updateUserId = updateUserId;
		this.updateDatetime = updateDatetime;
	}

	public int getCompanyNo() {
		return companyNo;
	}

	public void setCompanyNo(int companyNo) {
		this.companyNo = companyNo;
	}

	public String getCompanyId() {
		return companyId;
	}

	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}

	public String getCompanyNm() {
		return companyNm;
	}

	public void setCompanyNm(String companyNm) {
		this.companyNm = companyNm;
	}

	public String getCeoNm() {
		return ceoNm;
	}

	public void setCeoNm(String ceoNm) {
		this.ceoNm = ceoNm;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public String getMobileNo() {
		return mobileNo;
	}

	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}

	public String getFaxNo() {
		return faxNo;
	}

	public void setFaxNo(String faxNo) {
		this.faxNo = faxNo;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String getAcntBankNm() {
		return acntBankNm;
	}

	public void setAcntBankNm(String acntBankNm) {
		this.acntBankNm = acntBankNm;
	}

	public String getAcntNo() {
		return acntNo;
	}

	public void setAcntNo(String acntNo) {
		this.acntNo = acntNo;
	}

	public String getAcntUserNm() {
		return acntUserNm;
	}

	public void setAcntUserNm(String acntUserNm) {
		this.acntUserNm = acntUserNm;
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

	public int getDealCnt() {
		return dealCnt;
	}

	public void setDealCnt(int dealCnt) {
		this.dealCnt = dealCnt;
	}

}

