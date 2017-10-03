package wh;

public class Client {
	
	private int clientNo;
	private String clientNm;
	private String phoneNo;
	private String mobileNo;
	private String email;
	private String location;
	private String addr;
	private String note;
	private String insertUserId;
	private String insertDatetime;//10
	private String updateUserId;
	private String updateDatetime;
	
	private int dealCnt; //거래건수 
	
	public Client() {
	}
	
	public Client(int clientNo, String clientNm, String phoneNo, String mobileNo, String email, String location, String addr, String note, String insertUserId, String updateUserId) {
		this.clientNo = clientNo;
		this.clientNm = clientNm;
		this.phoneNo = phoneNo;
		this.mobileNo = mobileNo;
		this.email = email;
		this.location = location;
		this.addr = addr;
		this.note = note;
		this.insertUserId = insertUserId;
		this.updateUserId = updateUserId;
	}

	// list page 를 보여주기 위한..
	public Client(int clientNo, String clientNm, String phoneNo, String mobileNo, String email, String location, String addr, String note, String insertUserId, String insertDatetime, int dealCnt) {
		this.clientNo = clientNo;
		this.clientNm = clientNm;
		this.phoneNo = phoneNo;
		this.mobileNo = mobileNo;
		this.email = email;
		this.location = location;
		this.addr = addr;
		this.note = note;
		this.insertUserId = insertUserId;
		this.insertDatetime = insertDatetime;//10
		
		this.dealCnt = dealCnt;
	}

	public int getClientNo() {
		return clientNo;
	}

	public void setClientNo(int clientNo) {
		this.clientNo = clientNo;
	}

	public String getClientNm() {
		return clientNm;
	}

	public void setClientNm(String clientNm) {
		this.clientNm = clientNm;
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

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
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

}

