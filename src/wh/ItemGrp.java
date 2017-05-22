package wh;

public class ItemGrp {
	
	private int itemGrpNo;//i1
	
	private String itemGrpId;//1
	private int grp1Cd;
	private int grp2Cd;
	private int grp3Cd;//4
	private String grp1Nm;
	private String grp2Nm;
	private String grp3Nm;
	private String note;//8
	
	private String insertUserId;
	private String insertDatetime;//10
	private String updateUserId;
	private String updateDatetime;
	
	public ItemGrp() {
	}
	
	public ItemGrp(int itemGrpNo, String itemGrpId, int grp1Cd, int grp2Cd, int grp3Cd, String grp1Nm, String grp2Nm, String grp3Nm, String note, 
					String insertUserId, String insertDatetime, String updateUserId, String updateDatetime) {
		
		this.itemGrpNo = itemGrpNo;
		
		this.itemGrpId = itemGrpId;
		this.grp1Cd = grp1Cd;
		this.grp2Cd = grp2Cd;
		this.grp3Cd = grp3Cd;
		this.grp1Nm = grp1Nm;
		this.grp2Nm = grp2Nm;
		this.grp3Nm = grp3Nm;
		this.note = note;
		
		this.insertUserId = insertUserId;
		this.insertDatetime = insertDatetime;
		this.updateUserId = updateUserId;
		this.updateDatetime = updateDatetime;
	}

	public int getItemGrpNo() {
		return itemGrpNo;
	}

	public void setItemGrpNo(int itemGrpNo) {
		this.itemGrpNo = itemGrpNo;
	}

	public String getItemGrpId() {
		return itemGrpId;
	}

	public void setItemGrpId(String itemGrpId) {
		this.itemGrpId = itemGrpId;
	}

	public int getGrp1Cd() {
		return grp1Cd;
	}

	public void setGrp1Cd(int grp1Cd) {
		this.grp1Cd = grp1Cd;
	}

	public int getGrp2Cd() {
		return grp2Cd;
	}

	public void setGrp2Cd(int grp2Cd) {
		this.grp2Cd = grp2Cd;
	}

	public int getGrp3Cd() {
		return grp3Cd;
	}

	public void setGrp3Cd(int grp3Cd) {
		this.grp3Cd = grp3Cd;
	}

	public String getGrp1Nm() {
		return grp1Nm;
	}

	public void setGrp1Nm(String grp1Nm) {
		this.grp1Nm = grp1Nm;
	}

	public String getGrp2Nm() {
		return grp2Nm;
	}

	public void setGrp2Nm(String grp2Nm) {
		this.grp2Nm = grp2Nm;
	}

	public String getGrp3Nm() {
		return grp3Nm;
	}

	public void setGrp3Nm(String grp3Nm) {
		this.grp3Nm = grp3Nm;
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
}

