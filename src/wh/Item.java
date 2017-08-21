package wh;

import java.text.NumberFormat;
import java.util.Locale;

public class Item {
	
	private int itemNo;
	private String itemId;
	private String itemNm;
	private String itemNmKor;
	private String sku;
	private String vendorId;
	private float price;
	private String curCd;
	private int priceMeta;
	private int priceFactory;
	private int priceCenter;
	private int priceClient;
	private float serviceHour;
	private int moqVendor;
	private int moqCenter;
	private int requiredStockCnt;
	private int defectStockCnt;
	private String linkItem;
	private String linkInvoice;
	private String note;
	
	private String insertUserId;
	private String insertDatetime;
	private String updateUserId;
	private String updateDatetime;
	
	private int itemCnt; // from whItem
	
	private int srcItemCnt; // from to
	private int destItemCnt; // from to
	
	// po
	private int whItemCnt; //=itemCnt
	private int orderItemCnt;
	private int itemRcvCnt;
	private int itemNoRcvCnt;
	private int itemNewRcvCnt;
	
	public Item() {
	}
	
	public Item(int itemNo, String itemId, String itemNm, String itemNmKor) {
		this.itemNo = itemNo;
		this.itemId = itemId;
		this.itemNm = itemNm;
		this.itemNmKor = itemNmKor;
	}
	
	// basic Item table info 
	public Item(int itemNo, String itemId, String itemNm, String itemNmKor, String sku, String vendorId, float price, String curCd, int priceMeta, int priceFactory, int priceCenter, int priceClient, float serviceHour, int moqVendor, int moqCenter, int requiredStockCnt, int defectStockCnt, String linkItem, String linkInvoice, String note, String insertUserId, String insertDatetime, String updateUserId, String updateDatetime) {
		this.itemNo = itemNo;
		this.itemId = itemId;
		this.itemNm = itemNm;
		this.itemNmKor = itemNmKor;
		
		this.sku = sku;
		this.vendorId = vendorId;
		this.price = price;
		this.curCd = curCd;
		this.priceMeta = priceMeta;
		this.priceFactory = priceFactory;
		this.priceCenter = priceCenter;
		this.priceClient = priceClient;
		this.serviceHour = serviceHour;
		this.moqVendor = moqVendor;
		this.moqCenter = moqCenter;
		this.requiredStockCnt = requiredStockCnt;
		this.defectStockCnt = defectStockCnt;
		this.linkItem = linkItem;
		
		this.linkInvoice = linkInvoice;
		this.note = note;
		this.insertUserId = insertUserId;
		this.insertDatetime = insertDatetime;
		this.updateUserId = updateUserId;
		this.updateDatetime = updateDatetime;
	}

	// include itemCnt
	public Item(int itemNo, String itemId, String itemNm, String itemNmKor, String sku, String vendorId, float price, String curCd, int priceMeta, int priceFactory, int priceCenter, int priceClient, float serviceHour, int moqVendor, int moqCenter, int requiredStockCnt, int defectStockCnt, String linkItem, String linkInvoice, String note, String insertUserId, String insertDatetime, String updateUserId, String updateDatetime, int itemCnt) {
		this.itemNo = itemNo;
		this.itemId = itemId;
		this.itemNm = itemNm;
		this.itemNmKor = itemNmKor;
		
		this.sku = sku;
		this.vendorId = vendorId;
		this.price = price;
		this.curCd = curCd;
		this.priceMeta = priceMeta;
		this.priceFactory = priceFactory;
		this.priceCenter = priceCenter;
		this.priceClient = priceClient;
		this.serviceHour = serviceHour;
		this.moqVendor = moqVendor;
		this.moqCenter = moqCenter;
		this.requiredStockCnt = requiredStockCnt;
		this.defectStockCnt = defectStockCnt;
		this.linkItem = linkItem;
		
		this.linkInvoice = linkInvoice;
		this.note = note;
		this.insertUserId = insertUserId;
		this.insertDatetime = insertDatetime;
		this.updateUserId = updateUserId;
		this.updateDatetime = updateDatetime;

		this.itemCnt = itemCnt;
	}
	
	// include srcItemCnt, destItemCnt
	public Item(int itemNo, String itemId, String itemNm, String itemNmKor, String sku, String vendorId, float price, String curCd, int priceMeta, int priceFactory, int priceCenter, int priceClient, float serviceHour, int moqVendor, int moqCenter, int requiredStockCnt, int defectStockCnt, String linkItem, String linkInvoice, String note, String insertUserId, String insertDatetime, String updateUserId, String updateDatetime, int srcItemCnt, int destItemCnt) {
		this.itemNo = itemNo;
		this.itemId = itemId;
		this.itemNm = itemNm;
		this.itemNmKor = itemNmKor;
		
		this.sku = sku;
		this.vendorId = vendorId;
		this.price = price;
		this.curCd = curCd;
		this.priceMeta = priceMeta;
		this.priceFactory = priceFactory;
		this.priceCenter = priceCenter;
		this.priceClient = priceClient;
		this.serviceHour = serviceHour;
		this.moqVendor = moqVendor;
		this.moqCenter = moqCenter;
		this.requiredStockCnt = requiredStockCnt;
		this.defectStockCnt = defectStockCnt;
		this.linkItem = linkItem;
		
		this.linkInvoice = linkInvoice;
		this.note = note;
		this.insertUserId = insertUserId;
		this.insertDatetime = insertDatetime;
		this.updateUserId = updateUserId;
		this.updateDatetime = updateDatetime;

		this.srcItemCnt = srcItemCnt;
		this.destItemCnt = destItemCnt;
	}
	
	public String getItemId() {
		return itemId;
	}

	public int getMoqVendor() {
		return moqVendor;
	}

	public void setMoqVendor(int moqVendor) {
		this.moqVendor = moqVendor;
	}

	public int getMoqCenter() {
		return moqCenter;
	}

	public void setMoqCenter(int moqCenter) {
		this.moqCenter = moqCenter;
	}

	public int getRequiredStockCnt() {
		return requiredStockCnt;
	}

	public void setRequiredStockCnt(int requiredStockCnt) {
		this.requiredStockCnt = requiredStockCnt;
	}

	public int getDefectStockCnt() {
		return defectStockCnt;
	}

	public void setDefectStockCnt(int defectStockCnt) {
		this.defectStockCnt = defectStockCnt;
	}

	public String getLinkItem() {
		return linkItem;
	}

	public void setLinkItem(String linkItem) {
		this.linkItem = linkItem;
	}

	public String getLinkInvoice() {
		return linkInvoice;
	}

	public void setLinkInvoice(String linkInvoice) {
		this.linkInvoice = linkInvoice;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
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

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}

	public String getItemNmKor() {
		return itemNmKor;
	}

	public void setItemNmKor(String itemNmKor) {
		this.itemNmKor = itemNmKor;
	}

	public String getSku() {
		return sku;
	}

	public void setSku(String sku) {
		this.sku = sku;
	}

	public String getVendorId() {
		return vendorId;
	}

	public void setVendorId(String vendorId) {
		this.vendorId = vendorId;
	}

	public float getPrice() {
		return price;
	}

	public void setPrice(float price) {
		this.price = price;
	}

	public String getCurCd() {
		return curCd;
	}

	public void setCurCd(String curCd) {
		this.curCd = curCd;
	}

	public int getPriceMeta() {
		return priceMeta;
	}

	public void setPriceMeta(int priceMeta) {
		this.priceMeta = priceMeta;
	}

	public int getPriceFactory() {
		return priceFactory;
	}

	public void setPriceFactory(int priceFactory) {
		this.priceFactory = priceFactory;
	}
	
	public String getPriceCenterStr() {
		return NumberFormat.getCurrencyInstance(Locale.KOREA).format(priceCenter);
	}

	public int getPriceCenter() {
		return priceCenter;
	}

	public void setPriceCenter(int priceCenter) {
		this.priceCenter = priceCenter;
	}
	
	public String getPriceClientStr() {
		return NumberFormat.getCurrencyInstance(Locale.KOREA).format(priceClient);
	}

	public int getPriceClient() {
		return priceClient;
	}

	public void setPriceClient(int priceClient) {
		this.priceClient = priceClient;
	}

	public float getServiceHour() {
		return serviceHour;
	}

	public void setServiceHour(float serviceHour) {
		System.out.println("[L SetServiceHour] " + serviceHour);
		this.serviceHour = serviceHour;
	}

	public int getItemNo() {
		return itemNo;
	}

	public void setItemNo(int itemNo) {
		this.itemNo = itemNo;
	}

	public String getItemNm() {
		return itemNm;
	}

	public void setItemNm(String itemNm) {
		this.itemNm = itemNm;
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

	public int getItemCnt() {
		return itemCnt;
	}

	public void setItemCnt(int itemCnt) {
		this.itemCnt = itemCnt;
	}

	public int getSrcItemCnt() {
		return srcItemCnt;
	}

	public void setSrcItemCnt(int srcItemCnt) {
		this.srcItemCnt = srcItemCnt;
	}

	public int getDestItemCnt() {
		return destItemCnt;
	}

	public void setDestItemCnt(int destItemCnt) {
		this.destItemCnt = destItemCnt;
	}

	public int getWhItemCnt() {
		return whItemCnt;
	}

	public void setWhItemCnt(int whItemCnt) {
		this.whItemCnt = whItemCnt;
	}

	public int getOrderItemCnt() {
		return orderItemCnt;
	}

	public void setOrderItemCnt(int orderItemCnt) {
		this.orderItemCnt = orderItemCnt;
	}

	public int getItemRcvCnt() {
		return itemRcvCnt;
	}

	public void setItemRcvCnt(int itemRcvCnt) {
		this.itemRcvCnt = itemRcvCnt;
	}

	public int getItemNoRcvCnt() {
		return itemNoRcvCnt;
	}

	public void setItemNoRcvCnt(int itemNoRcvCnt) {
		this.itemNoRcvCnt = itemNoRcvCnt;
	}
	
	public int getItemNewRcvCnt() {
		return itemNewRcvCnt;
	}

	public void setItemNewRcvCnt(int itemNewRcvCnt) {
		this.itemNewRcvCnt = itemNewRcvCnt;
	}
	
}

