package wh;

public class Wh {

	private int whNo;
	private String whId;
	private String whNm;
	private String whType;
	
	public Wh() {
		// TODO Auto-generated constructor stub
	}
	
	public Wh(int whNo, String whId, String whNm, String whType) {
		this.whNo = whNo;
		this.whId = whId;
		this.whNm = whNm;	
		this.whType = whType;	
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
	
	public String getWhType() {
		return whType;
	}

	public void setWhType(String whType) {
		this.whType = whType;
	}
	
}
