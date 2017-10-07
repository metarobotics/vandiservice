package wh;

public class ItemStockHist {

	private int whNo;
	private int itemNo;
	private String dealDt;
	private int dealSeq;
	private String dealType;
	
	private String orderType;//6
	private int orderNo;
	private int beforeCnt;
	private int dealCnt;
	private int afterCnt;
	
	private String insertUserId;//11 
	private String insertDatetime;
	private String updateUserId;
	private String updateDatetime;

	private String whNm;//15
	private String itemNm;
	private String dealTypeStr; // 입고/출고
	private String orderNoStr;
	// TO 경우 
	private String srcWhNm;//19
	private String destWhNm;
	
	// for insert 
	public ItemStockHist(int whNo, int itemNo, String dealType, String orderType, int orderNo, int dealCnt, String insertUserId) {
		this.whNo = whNo;
		this.itemNo = itemNo;
		//this.dealDt = dealDt;
		//this.dealSeq = dealSeq;
		this.dealType = dealType;
		this.orderType = orderType;
		this.orderNo = orderNo;
		//this.beforeCnt = beforeCnt;
		this.dealCnt = dealCnt;
		//this.afterCnt = afterCnt;
		this.insertUserId = insertUserId;
		//this.insertDatetime = insertDatetime;
	}
	
	// for list view 
	public ItemStockHist(int whNo, int itemNo, String dealDt, int dealSeq, String dealType, String orderType,
			int orderNo, int beforeCnt, int dealCnt, int afterCnt, String insertDatetime, 
			String whNm, String itemNm, String dealTypeStr, String srcWhNm, String destWhNm) {
		this.whNo = whNo;
		this.itemNo = itemNo;
		this.dealDt = dealDt;
		this.dealSeq = dealSeq;
		this.dealType = dealType;
		this.orderType = orderType;
		this.orderNo = orderNo;
		this.beforeCnt = beforeCnt;
		this.dealCnt = dealCnt;
		this.afterCnt = afterCnt;
		this.insertDatetime = insertDatetime;
		
		this.whNm = whNm;
		this.itemNm = itemNm;
		this.dealTypeStr = dealTypeStr;

		this.srcWhNm = srcWhNm;
		this.destWhNm = destWhNm;
	}
		
	public int getWhNo() {
		return whNo;
	}
	public void setWhNo(int whNo) {
		this.whNo = whNo;
	}
	public int getItemNo() {
		return itemNo;
	}
	public void setItemNo(int itemNo) {
		this.itemNo = itemNo;
	}
	public String getDealDt() {
		return dealDt;
	}
	public void setDealDt(String dealDt) {
		this.dealDt = dealDt;
	}
	public int getDealSeq() {
		return dealSeq;
	}
	public void setDealSeq(int dealSeq) {
		this.dealSeq = dealSeq;
	}
	public String getDealType() {
		return dealType;
	}
	public void setDealType(String dealType) {
		this.dealType = dealType;
	}
	public String getOrderType() {
		return orderType;
	}
	public void setOrderType(String orderType) {
		this.orderType = orderType;
	}
	public int getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}
	public int getBeforeCnt() {
		return beforeCnt;
	}
	public void setBeforeCnt(int beforeCnt) {
		this.beforeCnt = beforeCnt;
	}
	public int getDealCnt() {
		return dealCnt;
	}
	public void setDealCnt(int dealCnt) {
		this.dealCnt = dealCnt;
	}
	public int getAfterCnt() {
		return afterCnt;
	}
	public void setAfterCnt(int afterCnt) {
		this.afterCnt = afterCnt;
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

	
	public String getWhNm() {
		return whNm;
	}

	public void setWhNm(String whNm) {
		this.whNm = whNm;
	}

	public String getItemNm() {
		return itemNm;
	}

	public void setItemNm(String itemNm) {
		this.itemNm = itemNm;
	}

	public String getDealTypeStr() {
		return dealTypeStr;
	}

	public void setDealTypeStr(String dealTypeStr) {
		this.dealTypeStr = dealTypeStr;
	}

	public String getOrderNoStr() {
		return orderNoStr;
	}

	public void setOrderNoStr(String orderNoStr) {
		this.orderNoStr = orderNoStr;
	}	
	
	
		
	public String getSrcWhNm() {
		return srcWhNm;
	}

	public void setSrcWhNm(String srcWhNm) {
		this.srcWhNm = srcWhNm;
	}

	public String getDestWhNm() {
		return destWhNm;
	}

	public void setDestWhNm(String destWhNm) {
		this.destWhNm = destWhNm;
	}


}
