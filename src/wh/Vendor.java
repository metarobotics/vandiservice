package wh;

public class Vendor {
	
	private int vendorNo;
	private String vendorNm;
	private String phoneNo;
	private String mobileNo;
	private String faxNo;
	
	private String chargeEmpNm;
	private String email;
	private String countryCd;
	private String addr;
	private String note;

	private String insertUserId;
	private String insertDatetime;//12
	private String updateUserId;
	private String updateDatetime;
	
	private int dealCnt; //거래건수 
	private String countryNm;  
	
	public Vendor() {
	}
	
	public Vendor(int vendorNo, String vendorNm, String phoneNo, String mobileNo, String faxNo, String chargeEmpNm, String email, String countryCd, String addr, String note, String insertUserId, String updateUserId) {
		this.vendorNo = vendorNo;
		this.vendorNm = vendorNm;
		this.phoneNo = phoneNo;
		this.faxNo = faxNo;
		this.chargeEmpNm = chargeEmpNm;
		this.mobileNo = mobileNo;
		this.email = email;
		this.countryCd = countryCd;
		this.addr = addr;
		this.note = note;
		this.insertUserId = insertUserId;
		this.updateUserId = updateUserId;
	}

	// list page 를 보여주기 위한..
	public Vendor(int vendorNo, String vendorNm, String phoneNo, String mobileNo, String faxNo, String chargeEmpNm, String email, String countryCd, String addr, String note, String insertUserId, String insertDatetime, int dealCnt, String countryNm) {
		this.vendorNo = vendorNo;
		this.vendorNm = vendorNm;
		this.phoneNo = phoneNo;
		this.faxNo = faxNo;
		this.chargeEmpNm = chargeEmpNm;
		this.mobileNo = mobileNo;
		this.email = email;
		this.countryCd = countryCd;
		this.addr = addr;
		this.note = note;
		this.insertUserId = insertUserId;
		this.insertDatetime = insertDatetime;//10
		
		this.dealCnt = dealCnt;
		this.countryNm = countryNm;
	}

	public int getVendorNo() {
		return vendorNo;
	}

	public void setVendorNo(int vendorNo) {
		this.vendorNo = vendorNo;
	}

	public String getVendorNm() {
		return vendorNm;
	}

	public void setVendorNm(String vendorNm) {
		this.vendorNm = vendorNm;
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

	public String getChargeEmpNm() {
		return chargeEmpNm;
	}

	public void setChargeEmpNm(String chargeEmpNm) {
		this.chargeEmpNm = chargeEmpNm;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getCountryCd() {
		return countryCd;
	}

	public void setCountryCd(String countryCd) {
		this.countryCd = countryCd;
	}
	
	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
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

	public int getDealCnt() {
		return dealCnt;
	}

	public void setDealCnt(int dealCnt) {
		this.dealCnt = dealCnt;
	}

	public String getCountryNm() {
		return countryNm;
	}

	public void setCountryNm(String countryNm) {
		this.countryNm = countryNm;
	}


}

