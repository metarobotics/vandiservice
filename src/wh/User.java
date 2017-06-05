package wh;

public class User {
	
	private int userNo;
	private String userId;
	private String userNm;
	private String authLvl;
	private int whNo;
	private String whId;
	private String whNm;
	private int insertUserNo;
	private String insertDatetime;
	
	public User() {
	}
	
	public User(int userNo, String userId, String userNm, String authLvl, int whNo, String whId, String whNm, int insertUserNo, String insertDatetime) {
		this.userNo = userNo;
		this.userId = userId;
		this.userNm = userNm;
		this.authLvl = authLvl;
		this.whNo = whNo;
		this.whId = whId;
		this.whNm = whNm;
		this.insertUserNo = insertUserNo;
		this.insertDatetime = insertDatetime;
	}

	public User(int userNo, String userId, String userNm, String authLvl, int whNo, String whId, String whNm) {
		this.userNo = userNo;
		this.userId = userId; 
		this.userNm = userNm;
		this.authLvl = authLvl;
		this.whNo = whNo;
		this.whId = whId;
		this.whNm = whNm;
	}

	
	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	public String getUserNm() {
		return userNm;
	}

	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	
	public String getAuthLvl() {
		return authLvl;
	}

	public void setAuthLvl(String authLvl) {
		this.authLvl = authLvl;
	}

	public int getWhNo() {
		return whNo;
	}

	public void setWhNo(int whNo) {
		this.whNo = whNo;
	}

	public String getWhId() {
		return whId;
	}

	public void setWhId(String whId) {
		this.whId = whId;
	}
	
	public String getWhNm() {
		return whNm;
	}

	public void setWhNm(String whNm) {
		this.whNm = whNm;
	}
	
	public int getInsertUserNo() {
		return insertUserNo;
	}

	public void setInsertUserNo(int insertUserNo) {
		this.insertUserNo = insertUserNo;
	}

	public String getInsertDatetime() {
		return insertDatetime;
	}

	public void setInsertDatetime(String insertDatetime) {
		this.insertDatetime = insertDatetime;
	}


}

