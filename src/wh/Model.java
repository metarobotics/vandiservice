package wh;

public class Model {
	
	private int modelNo;//1
	
	private String modelId;//2
	private String modelNmKor;
	private String modelNmEng;
	private String createDt;//5
	
	private String insertUserId;//6
	private String insertDatetime;
	private String updateUserId;
	private String updateDatetime;//9
	
	public Model() {
	}
	
	public Model(int modelNo, String modelId, String modelNmKor, String modelNmEng, String createDt, 
					String insertUserId, String insertDatetime, String updateUserId, String updateDatetime) {
		
		this.modelNo = modelNo;
		
		this.modelId = modelId;
		this.modelNmKor = modelNmKor;
		this.modelNmEng = modelNmEng;
		this.createDt = createDt;
		
		this.insertUserId = insertUserId;
		this.insertDatetime = insertDatetime;
		this.updateUserId = updateUserId;
		this.updateDatetime = updateDatetime;
	}

	public int getModelNo() {
		return modelNo;
	}

	public void setModelNo(int modelNo) {
		this.modelNo = modelNo;
	}

	public String getModelId() {
		return modelId;
	}

	public void setModelId(String modelId) {
		this.modelId = modelId;
	}

	public String getModelNmKor() {
		return modelNmKor;
	}

	public void setModelNmKor(String modelNmKor) {
		this.modelNmKor = modelNmKor;
	}

	public String getModelNmEng() {
		return modelNmEng;
	}

	public void setModelNmEng(String modelNmEng) {
		this.modelNmEng = modelNmEng;
	}

	public String getCreateDt() {
		return createDt;
	}

	public void setCreateDt(String createDt) {
		this.createDt = createDt;
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

