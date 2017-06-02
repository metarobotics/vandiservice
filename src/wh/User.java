package wh;

public class User {
	
	private int userNo;
	private String userId;
	private String userNm;
	private int insertUserNo;
	private String insertDatetime;
	private int whNo;
	
	public User() {
	}
	
	public User(int userNo, String userId, String userNm, int insertUserNo, String insertDatetime, int whNo) {
		this.userNo = userNo;
		this.userId = userId;
		this.userNm = userNm;
		this.insertUserNo = insertUserNo;
		this.insertDatetime = insertDatetime;
		this.whNo = whNo;
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
	
	public void setUserWhNo(int whNo) {
		this.whNo = whNo;
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
	
	public int getUserWhNo() {
		return whNo;
	}
}

