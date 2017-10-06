package common;

public class Code {

	private String classCd;
	private String cd;
	private String cd1;
	private String cd2;
	private String cd3;
	
	private String cdNm; //6
	private int amt;
	private String note;
	private int sortNo;
	private String useYn;
	
	private String insertUserId; //11
	private String insertDatetime;
	private String updateUserId;
	private String updateDatetime;
	
	public Code(String classCd, String cd, String cd1, String cd2, String cd3, String cdNm, int amt,
			String note, int sortNo, String useYn, String insertUserId, String insertDatetime, String updateUserId,
			String updateDatetime) {
		super();
		this.classCd = classCd;
		this.cd = cd;
		this.cd1 = cd1;
		this.cd2 = cd2;
		this.cd3 = cd3;
		this.cdNm = cdNm;
		this.amt = amt;
		this.note = note;
		this.sortNo = sortNo;
		this.useYn = useYn;
		this.insertUserId = insertUserId;
		this.insertDatetime = insertDatetime;
		this.updateUserId = updateUserId;
		this.updateDatetime = updateDatetime;
	}
	
	public String getClassCd() {
		return classCd;
	}
	public void setClassCd(String classCd) {
		this.classCd = classCd;
	}
	public String getCd() {
		return cd;
	}
	public void setCd(String cd) {
		this.cd = cd;
	}
	public String getCd1() {
		return cd1;
	}
	public void setCd1(String cd1) {
		this.cd1 = cd1;
	}
	public String getCd2() {
		return cd2;
	}
	public void setCd2(String cd2) {
		this.cd2 = cd2;
	}
	public String getCd3() {
		return cd3;
	}
	public void setCd3(String cd3) {
		this.cd3 = cd3;
	}
	public String getCdNm() {
		return cdNm;
	}
	public void setCdNm(String cdNm) {
		this.cdNm = cdNm;
	}
	public int getAmt() {
		return amt;
	}
	public void setAmt(int amt) {
		this.amt = amt;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public int getSortNo() {
		return sortNo;
	}
	public void setSortNo(int sortNo) {
		this.sortNo = sortNo;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
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
